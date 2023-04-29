//
//  MoviesEndpoint.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 29.04.2023.
//

import Foundation

enum MoviesEndpoint {
    case top250
    case detail
    case search
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .top250:
            return "/en/API/Top250Movies"
        case .detail:
            return "/en/API/Title"
        case .search:
            return "/en/API/SearchMovie"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .top250, .detail, .search:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
}
