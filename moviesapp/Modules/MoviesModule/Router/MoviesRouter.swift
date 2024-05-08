//
//  MoviesRouter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation

protocol MoviesRouterProtocol : AnyObject{
    
}

class MoviesRouter {
    
    weak var currentViewController: MoviesViewController?
    
    init(withView view: MoviesViewController) {
        self.currentViewController = view
    }
    
}

extension MoviesRouter: MoviesRouterProtocol{
    
}
