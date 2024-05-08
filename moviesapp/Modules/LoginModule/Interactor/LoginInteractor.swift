//
//  LoginInteractor.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 8/05/24.
//

import Foundation

protocol LoginInteractorProtocol : AnyObject {
    func login(username: String, password: String, completion: @escaping (Bool)->())
}

class LoginInteractor {
    
}

extension LoginInteractor: LoginInteractorProtocol{
    
    func login(username: String, password: String, completion: @escaping (Bool)->()) {
        // validate login
        if(username == "admin" && password == "awdr"){
            completion(true)
        } else {
            completion(false)
        }
    }
    
}

