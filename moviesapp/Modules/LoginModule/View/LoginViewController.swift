//
//  LoginViewController.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func showErrorMsg()
}

class LoginViewController: UIViewController {
    
    //viper
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // config viper
        let conf = LoginConfigurator()
        conf.configurate(controller: self)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        presenter?.fetchLogin(username: usernameTextField.text ?? "",
                              password: passwordTextField.text ?? "")
    }
    
}

extension LoginViewController: LoginViewControllerProtocol {
    func showErrorMsg() {
        print("Error login")
    }
}

class LoginConfigurator {
    func configurate(controller: LoginViewController) {
        let router = LoginRouter(withView: controller)
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: controller, router: router, interactor: interactor)
        controller.presenter = presenter
    }
}
