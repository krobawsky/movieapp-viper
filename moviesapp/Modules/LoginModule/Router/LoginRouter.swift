//
//  LoginRouter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation

protocol LoginRouterProtocol : AnyObject{
    func goToMovies()
}

class LoginRouter {
    
    var moviesRouter: MoviesRouter?
    weak var currentViewController: LoginViewController?
    
    init(withView view: LoginViewController) {
        self.moviesRouter = MoviesRouter()
        self.currentViewController = view
    }
    
}

extension LoginRouter: LoginRouterProtocol {
    func goToMovies() {
        guard let vc = currentViewController else {
            return
        }
        moviesRouter?.showMovies(fromViewController: vc)
    }
}

