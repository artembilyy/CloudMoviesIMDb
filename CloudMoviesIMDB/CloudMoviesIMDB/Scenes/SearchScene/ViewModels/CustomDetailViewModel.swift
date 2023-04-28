//
//  CustomDetailViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import Foundation

protocol CustomDetailViewModelProtocol {
    var movie: Movies.Movie { get }
}

final class CustomDetailViewModel: CustomDetailViewModelProtocol {
    
    var movie: Movies.Movie
    let network: NetworkCustomDetailServiceProtocol
    
    init(movie: Movies.Movie, network: NetworkCustomDetailServiceProtocol) {
        self.movie = movie
        self.network = network
        print("CustomDetailViewModel init")
    }
    func getMovieInfo() {
        Task {
            do {
                guard let movieID = movie.id else { return }
                let result = try await network.getDetailScreen(movieID: movieID)
                self.movie = result
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    deinit {
        print("CustomDetailViewModel deinit")
    }
}
