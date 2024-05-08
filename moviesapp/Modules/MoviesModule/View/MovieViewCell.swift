//
//  MovieViewCell.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 7/05/24.
//

import UIKit
import AlamofireImage

class MovieViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbVotes: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupStyles() {
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 10.0
        ivPoster.layer.masksToBounds = true
    }
    
    func setMovie(_ movie: MovieModel) {
        // Asignacion de labels
        lbTitle.text = movie.title
        lbVotes.text = String(movie.votes)
        // Cargar de imagen desde url
        if let url = URL(string: Endpoint.baseMovieDbPoster + movie.poster){
            ivPoster.af.setImage(withURL: url)
        }
        setupStyles()
    }
    
}
