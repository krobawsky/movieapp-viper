//
//  MoviesInteractor.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import Alamofire

protocol MoviesInteractorProtocol : AnyObject {
    func getUpcomingMovies( completion: @escaping ([MovieEntity], AFError?)->())
}

class MoviesInteractor {
    let api = BaseServerManager()
}

extension MoviesInteractor: MoviesInteractorProtocol{
    func getUpcomingMovies(completion: @escaping ([MovieEntity], Alamofire.AFError?) -> ()) {
        
        let url = "\(Endpoint.baseMovieDb)/movie/upcoming"
        
        api.sessionManager
            .request(url, method: .get)
            .validate()
            .responseDecodable { (response: AFDataResponse<MoviesResponseEntity>) in
                print(response)
                switch response.result{
                case .success(let value):
                    completion(value.results, nil)
                case .failure(let error):
                    completion([], error)
                }
            }
    }
}

