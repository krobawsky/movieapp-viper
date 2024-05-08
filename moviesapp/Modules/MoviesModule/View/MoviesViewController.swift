//
//  MoviesViewController.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import UIKit

protocol MoviesViewControllerProtocol: AnyObject {
    func refreshCollectionView()
}

class MoviesViewController: UIViewController {
    
    //viper
    var presenter: MoviesPresenterProtocol?
    
    @IBOutlet weak var cvMovies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conf = MoviesConfigurator()
        conf.configurate(controller: self)
        
        configurateCollectionView()
        
        presenter?.fetchMovies()
        
    }
    
    func configurateCollectionView(){
        cvMovies.dataSource = self
        cvMovies.delegate = self
        cvMovies.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getMovies().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! MovieViewCell
        if let movie = presenter?.getMovie(at: indexPath.row) {
            cell.setMovie(movie)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieDetail(at: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: 320)
    }
}

extension MoviesViewController : MoviesViewControllerProtocol {
    
    func refreshCollectionView(){
        cvMovies.reloadData()
    }
}

class MoviesConfigurator {
    func configurate(controller: MoviesViewController) {
        let router = MoviesRouter(withView: controller)
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter(view: controller, router: router, interactor: interactor)
        controller.presenter = presenter
    }
}
