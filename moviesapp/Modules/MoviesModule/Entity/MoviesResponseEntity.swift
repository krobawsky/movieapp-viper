//
//  MoviesResponseEntity.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation

struct MoviesResponseEntity: Codable {
    let results: [MovieEntity]
    let totalPages: Int
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case page
    }
}
