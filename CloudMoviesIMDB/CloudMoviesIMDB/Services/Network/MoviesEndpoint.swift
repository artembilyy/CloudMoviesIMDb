//
//  MoviesEndpoint.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 29.04.2023.
//

import Foundation

enum MoviesEndpoint {
    case top250
    case detail(id: String)
    case search(query: String)
    case resizeImage
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .top250:
            return "/en/API/Top250Movies/\(Constants.API.apiKey)"
        case .detail(let id):
            return "/en/API/Title/\(Constants.API.apiKey)/\(id)/FullActor,FullCast,Posters,Images,Trailer,Ratings"
        case .search(let query):
            return "/en/API/SearchMovie/\(Constants.API.apiKey)/\(query)"
        case .resizeImage:
            return "/API/ResizeImage/"
        }
    }
    var method: RequestMethod {
        switch self {
        case .top250, .detail, .search, .resizeImage:
            return .get
        }
    }
    var header: [String: String]? {
        return nil
    }
    var body: [String: String]? {
        return nil
    }
}
