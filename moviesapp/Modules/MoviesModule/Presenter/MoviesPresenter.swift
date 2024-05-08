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
    func showMovieDetail(at index: Int)
}

class MoviesPresenter {
    
    //VIPER
    private var router: MoviesRouterProtocol
    private var interactor: MoviesInteractorProtocol
    private weak var view: MoviesViewControllerProtocol?
    
    var movies: [MovieModel] = []
    
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
        // check internet
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            print("Internet connection is off.")
            self.view?.showCoreData()
        }
        
        interactor.getUpcomingMovies(completion: { [weak self] (moviesEntity, error) in
            guard let welf = self else{ return }
            // Oculto loading
            if let error = error {
                print( error.errorDescription ?? "error" )
                welf.view?.showErrorMsg()
                return
            }
            // Respuesta exitosa
            welf.movies = moviesEntity.map({ entity in
                return entity.getModel()
            })
            
            welf.view?.refreshCollectionView()
        })
    }
    
    func showMovieDetail(at index: Int) {
        if let movie = getMovie(at: index) {
            router.showMovieDetail(movie)
        }
    }
    
}
