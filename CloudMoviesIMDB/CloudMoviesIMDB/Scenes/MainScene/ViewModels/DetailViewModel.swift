//
//  SubMainViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

protocol DetailViewModelProtocol {
    var movie: Movies.Movie { get }
}

final class DetailViewModel: DetailViewModelProtocol {
    let movie: Movies.Movie
    init(movie: Movies.Movie) {
        self.movie = movie
        print("DetailViewModel init")
    }
    deinit {
        print("DetailViewModel deinit")
    }
}
