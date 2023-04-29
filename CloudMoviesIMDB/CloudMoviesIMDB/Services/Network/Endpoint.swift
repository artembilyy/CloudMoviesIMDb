//
//  Endpoints.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import Foundation

struct Endpoints {
    static let resizeImage = "https://imdb-api.com/API/ResizeImage?apiKey="
    static let size = "&size=192x264"
    static let url = "&url="
    static let fullDetail = "FullActor,FullCast,Posters,Images,Trailer,Ratings"
    static let apiKey = "k_l7vmnrru" /// <--- Past your own API KEY HERE
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "imdb-api.com"
    }
}
