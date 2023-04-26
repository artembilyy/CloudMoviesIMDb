//
//  NetworkError.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noImage
    /// describing
    var describing: String {
        switch self {
        case .invalidURL:
            return "API Error: wrong URL."
        case .noImage:
            return "No image"
        }
    }
}
