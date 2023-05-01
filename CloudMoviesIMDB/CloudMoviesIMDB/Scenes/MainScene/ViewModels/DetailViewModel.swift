//
//  SubMainViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

protocol DetailViewModelProtocol {
    var movie: Movies.Movie? { get }
    var charactersData: CharactersCountModel? { get }
}

final class DetailViewModel: DetailViewModelProtocol {
    let movie: Movies.Movie?
    var charactersData: CharactersCountModel?
    // MARK: - Init
    init(movie: Movies.Movie) {
        self.movie = movie
        self.charactersData = eachCharactersCount()
        print("DetailViewModel init")
    }
    /// if i understand task correctly
    func eachCharactersCount() -> CharactersCountModel? {
        var charCount: [Character: Int] = [:]
        guard let title = movie?.title else { return nil }
        title.forEach {
            if !$0.isWhitespace {
                charCount[$0, default: 0] += 1
            }
        }
        return CharactersCountModel(data: charCount)
    }
    deinit {
        print("DetailViewModel deinit")
    }
}
