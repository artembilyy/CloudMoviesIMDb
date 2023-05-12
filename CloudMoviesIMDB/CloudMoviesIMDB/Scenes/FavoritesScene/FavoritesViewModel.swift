//
//  FavoritesViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 12.05.2023.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var favoriteMovies: [FavoritesMovies]? { get }
    var dataFetched: Observable<Bool?> { get }
    func getFavoritesMovies()
    func checkIsFavorite(movie: FavoritesMovies) -> Bool
    func deleteFromFavorites(_ movie: FavoritesMovies)
}
final class FavoritesViewModel: FavoritesViewModelProtocol {
    var favoriteMovies: [FavoritesMovies]? = []
    var dataFetched: Observable<Bool?> = Observable(nil)
    // MARK: - Data Source
    let dataSource: FavoritesMoviesStorageProtocol
    // MARK: - Init
    init(dataSource: FavoritesMoviesStorageProtocol) {
        self.dataSource = dataSource
        getFavoritesMovies()
    }
    func getFavoritesMovies() {
        favoriteMovies = dataSource.getFavoritesMovies()
        dataFetched.value = true
    }
    func deleteFromFavorites(_ movie: FavoritesMovies) {
        dataSource.deleteFavoriteMovieEntity(movie)
        getFavoritesMovies()
        dataFetched.value = true
    }
    func checkIsFavorite(movie: FavoritesMovies) -> Bool {
        dataSource.checkIsFavorite(movie: movie)
    }
    deinit {
        print("FavoritesViewModel deinit")
    }
}
