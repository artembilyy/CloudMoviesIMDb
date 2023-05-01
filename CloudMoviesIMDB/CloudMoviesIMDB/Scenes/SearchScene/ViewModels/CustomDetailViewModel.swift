//
//  CustomDetailViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import Foundation

protocol CustomDetailViewModelProtocol {
    var movie: Movies.Movie { get }
    func getMovieInfo() async
}

final class CustomDetailViewModel: CustomDetailViewModelProtocol {
    var movie: Movies.Movie
    let network: DetailMovieNetworkServiceProtocol
    // MARK: - Init
    init(movie: Movies.Movie, network: DetailMovieNetworkServiceProtocol) {
        self.movie = movie
        self.network = network
        print("CustomDetailViewModel init")
    }
    func getMovieInfo() async {
        do {
            guard let movieID = movie.id else { return }
            let movie = try await network.getDetailScreen(movieID: movieID)
            self.movie = movie
        } catch {
            print(error.localizedDescription)
        }
    }
    deinit {
        print("CustomDetailViewModel deinit")
    }
}
