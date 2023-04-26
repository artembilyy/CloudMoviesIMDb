//
//  MovieModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import Foundation

// MARK: - Movies
struct Movies: Decodable, Hashable {
    let items: [Movie]?
    let errorMessage: String?
}
// MARK: - Movie
extension Movies {
    struct Movie: Decodable, Hashable {
        let id: String?
        let rank: String?
        let title: String?
        let fullTitle: String?
        let year: String?
        let image: String?
        let crew: String?
        let imDBRating: String?
        let imDBRatingCount: String?
        var rankInt: Int {
            return Int(rank ?? "") ?? 0
        }
    }
}

extension Movies.Movie {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Movies.Movie: Equatable {
    static func == (lhs: Movies.Movie, rhs: Movies.Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
