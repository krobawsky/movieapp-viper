//
//  MoviesInteractor.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import Alamofire

protocol MoviesInteractorProtocol : AnyObject {
    func getUpcomingMovies(page: Int, completion: @escaping (MoviesResponseEntity?, AFError?)->())
}

class MoviesInteractor {
    let api = BaseServerManager()
}

extension MoviesInteractor: MoviesInteractorProtocol{
    func getUpcomingMovies(page: Int, completion: @escaping (MoviesResponseEntity?, Alamofire.AFError?) -> ()) {
        
        let url = "\(Endpoint.baseMovieDb)/movie/upcoming"
        let parameters: Parameters = [
            "page": String(page)
        ]
        
        api.sessionManager
            .request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable { (response: AFDataResponse<MoviesResponseEntity>) in
                print(response)
                switch response.result{
                case .success(let value):
                    completion(value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}

