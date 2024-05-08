//
//  MoviesRouter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation

protocol MoviesRouterProtocol : AnyObject{
    func showMovieDetail(_ movie: MovieModel)
}

class MoviesRouter {
    
    var movieDetailRouter: MovieDetailRouter?
    weak var currentViewController: MoviesViewController?
    
    init(withView view: MoviesViewController) {
        self.movieDetailRouter = MovieDetailRouter()
        self.currentViewController = view
    }
    
}

extension MoviesRouter: MoviesRouterProtocol {
    func showMovieDetail(_ movie: MovieModel) {
        guard let vc = currentViewController else {
            return
        }
        movieDetailRouter?.showDetail(fromViewController: vc, movie: movie)
    }
}
