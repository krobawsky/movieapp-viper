//
//  MoviesPresenter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import Reachability
import CoreData

protocol MoviesPresenterProtocol : AnyObject {
    func getMovies() -> [MovieModel]
    func getMovie(at index: Int) -> MovieModel?
    func fetchMovies()
    func nextPage()
    func isLastPage() -> Bool
    func showMovieDetail(at index: Int)
}

class MoviesPresenter {
    
    //VIPER
    private var router: MoviesRouterProtocol
    private var interactor: MoviesInteractorProtocol
    private weak var view: MoviesViewControllerProtocol?
    
    var movies: [MovieModel] = []
    
    // pagination
    var totalPages = 1
    var currentPage = 1
    var isLoading = false
    
    init(view: MoviesViewControllerProtocol,
         router: MoviesRouterProtocol,
         interactor: MoviesInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension MoviesPresenter: MoviesPresenterProtocol {
    
    func getMovies() -> [MovieModel] {
        return movies
    }
    
    func getMovie(at index: Int) -> MovieModel? {
        if index < movies.count{
            return movies[index]
        } else {
            return nil
        }
    }
    
    func fetchMovies(){
        if(isLoading) {
            return
        }
        // check internet
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            print("Internet connection is off.")
            self.view?.showErrorMsg()
        }
        // show loading
        isLoading = true
        view?.showLoadingIndicator()
        
        interactor.getUpcomingMovies(page: currentPage, completion: { [weak self] (moviesResponseEntity, error) in
            guard let welf = self else{ return }
            // Oculto loading
            if let error = error {
                print( error.errorDescription ?? "error" )
                // hide loading
                welf.isLoading = false
                welf.view?.hideLoadingIndicator()
                
                welf.view?.showErrorMsg()
                return
            }
            guard let moviesResponse = moviesResponseEntity else{ return }
            
            // Respuesta exitosa
            welf.totalPages = moviesResponse.totalPages
            welf.currentPage = moviesResponse.page
            welf.movies += moviesResponse.results.map({ entity in
                return entity.getModel()
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // hide loading
                welf.isLoading = false
                welf.view?.hideLoadingIndicator()
                
                welf.view?.refreshCollectionView()
            }
        })
    }
    
    func isLastPage() -> Bool {
        return currentPage < totalPages
    }
    
    func nextPage() {
        currentPage += 1
    }
    
    func showMovieDetail(at index: Int) {
        if let movie = getMovie(at: index) {
            router.showMovieDetail(movie)
        }
    }
    
}
