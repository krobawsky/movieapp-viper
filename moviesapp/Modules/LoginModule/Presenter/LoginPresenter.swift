//
//  LoginPresenter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation

protocol LoginPresenterProtocol {
    func login(username: String, password: String) -> Bool?
}
