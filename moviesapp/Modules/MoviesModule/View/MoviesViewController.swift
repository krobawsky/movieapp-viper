//
//  MoviesViewController.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import UIKit
import CoreData

protocol MoviesViewControllerProtocol: AnyObject {
    func refreshCollectionView()
    func showErrorMsg()
    func showCoreData()
}

class MoviesViewController: UIViewController {
    
    //viper
    var presenter: MoviesPresenterProtocol?
    
    //coredata
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var cvMovies: UICollectionView!
    @IBOutlet weak var lbError: UILabel!
    
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
    
    func showCoreData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                for data in fetchResult as! [NSManagedObject] {
                    print(data.value(forKey: "title") as! String)
                }
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func refreshCollectionView(){
        cvMovies.reloadData()
        saveCoreData()
    }
    
    private func saveCoreData() {
        // Guardar datos en core data
        self.presenter?.getMovies().forEach { movie in
            
            let newMovie = Movies(context: context)
            newMovie.id = Int32(movie.id)
            newMovie.title = movie.title
            newMovie.releaseDate = movie.releaseDate
            newMovie.voteAverage = movie.votes
            newMovie.overview = movie.overview
            newMovie.poster = movie.poster
            newMovie.backdrop = movie.backdrop
        }
        
        do {
          try context.save()
         } catch {
          print("Error saving")
        }
        
        // eliminar repetidos
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        request.predicate = NSPredicate(format: "id = %@")
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                for data in fetchResult {
                    context.delete(data as! NSManagedObject)
                }
            }
            // save
            do {
                try context.save()
            }
            catch {
                
            }
        } catch {
            print("Failed")
        }
    }
    
    func showErrorMsg() {
        lbError.isHidden = false
        cvMovies.isHidden = true
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
