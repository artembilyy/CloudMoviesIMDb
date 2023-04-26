//
//  SubMainViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

protocol SubMainViewModelProtocol {
    var movie: Movies.Movie { get }
}

final class SubMainViewModel: SubMainViewModelProtocol {
    let movie: Movies.Movie
    
    init(movie: Movies.Movie) {
        self.movie = movie
    }
}
