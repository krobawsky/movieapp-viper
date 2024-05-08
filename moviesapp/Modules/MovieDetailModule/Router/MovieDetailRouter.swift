//
//  MovieDetailRouter.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 7/05/24.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol : AnyObject{
    func showDetail(fromViewController: UIViewController,
                    movie: MovieModel)
}

class MovieDetailRouter : MovieDetailRouterProtocol {
    
    func showDetail(fromViewController: UIViewController, movie: MovieModel) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController else {
            fatalError("viewController failed while casting")
        }
        
        let presenter = MovieDetailPresenter(router: self, movie: movie)
        viewController.presenter = presenter
        
        fromViewController.present(viewController, animated: true)
    }
    
}
