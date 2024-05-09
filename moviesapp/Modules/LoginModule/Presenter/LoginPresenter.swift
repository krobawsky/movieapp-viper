//
//  LoginPresenter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation

protocol LoginPresenterProtocol {
    func fetchLogin(username: String, password: String)
}

class LoginPresenter {
    
    //VIPER
    private weak var view: LoginViewControllerProtocol?
    private var router: LoginRouterProtocol
    private var interactor: LoginInteractorProtocol
    
    init(view: LoginViewControllerProtocol,
         router: LoginRouterProtocol,
         interactor: LoginInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func fetchLogin(username: String, password: String) {
        interactor.login(username: username.lowercased(),
                         password: password.lowercased(),
                         completion: { [weak self] (success) in
            guard let welf = self else{ return }
            if(success) {
                welf.router.goToMovies()
            } else {
                welf.view?.showErrorMsg()
            }
        })
    }
    
}
