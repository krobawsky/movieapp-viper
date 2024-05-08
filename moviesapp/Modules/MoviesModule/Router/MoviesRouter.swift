//
//  MoviesRouter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import UIKit

protocol MoviesRouterProtocol : AnyObject{
    func showMovies(fromViewController: UIViewController)
    func showMovieDetail(_ movie: MovieModel)
}

class MoviesRouter {
    
    var movieDetailRouter: MovieDetailRouter?
    weak var currentViewController: MoviesViewController?
    
}

extension MoviesRouter: MoviesRouterProtocol {
    
    func showMovies(fromViewController: UIViewController) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: String(describing: MoviesViewController.self)) as? MoviesViewController else {
            fatalError("viewController failed while casting")
        }
        
        self.movieDetailRouter = MovieDetailRouter()
        self.currentViewController = viewController
        
        let router = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter(view: viewController, router: router, interactor: interactor)
        viewController.presenter = presenter
        
        viewController.modalPresentationStyle = .fullScreen
        fromViewController.present(viewController, animated: true)
    }
    
    func showMovieDetail(_ movie: MovieModel) {
        guard let vc = currentViewController else {
            return
        }
        movieDetailRouter?.showDetail(fromViewController: vc, movie: movie)
    }
}
