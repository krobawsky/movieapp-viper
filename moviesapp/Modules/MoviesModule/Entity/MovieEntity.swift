//
//  MovieEntity.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation

struct MovieEntity: Codable {
    let id: Int
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let overview: String
    let poster: String?
    let backdrop: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
    }
}

// Conversion a modelo
extension MovieEntity {
    func getModel() -> MovieModel{
        return MovieModel(
            id: id,
            title: title,
            votes: voteAverage,
            releaseDate: releaseDate,
            overview: overview,
            poster: poster ?? "",
            backdrop: backdrop ?? ""
        )
    }
}
