//
//  CustomDetailViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import Foundation

protocol CustomDetailViewModelProtocol {
    var movie: SearchResult.Movie { get }
}

final class CustomDetailViewModel: CustomDetailViewModelProtocol {
    let movie: SearchResult.Movie
    init(movie: SearchResult.Movie) {
        self.movie = movie
        print("CustomDetailViewModel init")
    }
    deinit {
        print("CustomDetailViewModel deinit")
    }
}
