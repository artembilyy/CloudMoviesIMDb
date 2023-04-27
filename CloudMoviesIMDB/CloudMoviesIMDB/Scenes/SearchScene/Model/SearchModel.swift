//
//  SearchModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import Foundation

struct SearchResult: Decodable, Hashable {
    let searchType: String?
    let expression: String?
    let results: [Movie]?
    let errorMessage: String?
}
extension SearchResult {
    struct Movie: Decodable, Hashable {
        let id: String?
        let resultType: String?
        let image: URL?
        let title: String?
        let description: String?
    }
}
