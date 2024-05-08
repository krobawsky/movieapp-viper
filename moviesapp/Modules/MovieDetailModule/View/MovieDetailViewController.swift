//
//  MovieDetailViewController.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 7/05/24.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var ivBackdrop: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbVotes: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    
    //viper
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    func setData() {
        guard let movie = presenter?.getMovie() else {
            return
        }
        
        lbTitle.text = movie.title
        lbDate.text = movie.releaseDate
        lbVotes.text = String(format: "%.1f", movie.votes)
        lbOverview.text = movie.overview
        // Cargar de imagen desde url
        if let url = URL(string: Endpoint.baseMovieDbPoster + movie.backdrop){
            ivBackdrop.af.setImage(withURL: url)
        }
    }
    
}
