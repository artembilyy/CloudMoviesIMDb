//
//  NetworkError.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import Foundation

enum NetworkError: Error {
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonDecodingFailure(description: String)
    case noInternetConnection
    case unexpectedStatusCode
    case invalidURL
    case noImage
    case unknown
    
    var description: String {
        switch self {
        case .requestFailed(let description):
            return "Request failed: \(description)"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful(let description):
            return "Response unsuccessful: \(description)"
        case .jsonDecodingFailure(let description):
            return "Json deconing failure desription: \(description)"
        case .noInternetConnection:
            return "No internet connection"
        case .unexpectedStatusCode:
            return "Unexpected status code"
        case .invalidURL:
            return "Invalid URL"
        case .noImage:
            return "Image failure"
        default:
            return "Unknown error"
        }
    }
}

