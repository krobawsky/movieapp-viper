//
//  MovieDbApi.swift
//  moviesapp
//
//  Created by Ricardo Daniel Berrospi Quispe on 6/05/24.
//

import Foundation
import Alamofire

class BaseServerManager: SessionDelegate{
    let sessionManager: Session
    
    // constant
    let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNjZlMjhjMjA4OTc0MGZkZDY1ZDdlNzdmNWQ0MzMyZCIsInN1YiI6IjY2Mzk2YjViNDcwZWFkMDEyYTEzOTk2MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aGdHkPXgo0O5L6GeEMZL-OVAuKr2Avh7Rae6sK5xr1g"
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.timeoutIntervalForResource = 400
        configuration.timeoutIntervalForRequest = 400
        configuration.headers = ["Authorization": "Bearer " + token]
        sessionManager = Alamofire.Session(configuration: configuration, serverTrustManager: nil)
    }
}

