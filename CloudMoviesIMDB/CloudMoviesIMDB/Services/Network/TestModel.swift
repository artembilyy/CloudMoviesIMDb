//
//  TestModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import Foundation


// MARK: - Movies
struct SearchResult: Codable, Hashable {
    let searchType: SearchTypeEnum?
    let expression: String?
    let results: [SearchMovies]?
    let errorMessage: String?
}

// MARK: - Result
extension SearchResult {
    struct SearchMovies: Codable, Hashable {
        let id: String?
        let resultType: SearchTypeEnum?
        let image: String?
        let title, description: String?
    }
    
    enum SearchTypeEnum: String, Codable {
        case movie = "Movie"
    }
}
