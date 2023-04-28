//
//  SearchViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import Foundation

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    func openDetailController(_ data: Movies.Movie)
}

protocol SearchViewModelProtocol {
    var movies: [SearchResult.SearchMovies] { get }
    var snapshotUpdate: Observable<Bool?> { get }
    var errorMessage: Observable<String?> { get }
    func getSearchResultsMovies(queryString: String)
    func openDetailController(_ data: Movies.Movie)
    func reload()
}

final class SearchViewModel: SearchViewModelProtocol {
    private(set) var movies: [SearchResult.SearchMovies] = []
    // MARK: - Binding
    var snapshotUpdate: Observable<Bool?> = Observable(nil)
    var errorMessage: Observable<String?> = Observable(nil)
    /// delegate
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    // MARK: - Network
    let networkService: NetworkSearchServiceProtocol
    // MARK: - Init
    init(networkService: NetworkSearchServiceProtocol) {
        self.networkService = networkService
    }
    func reload() {
        movies.removeAll()
        snapshotUpdate.value = true
    }
    func getSearchResultsMovies(queryString: String) {
        snapshotUpdate.value = false
        Task {
            do {
                let result = try await self.networkService.getSearchedMovies(query: queryString)
                self.movies = result
                snapshotUpdate.value = true
            } catch {
                print(error.localizedDescription)
                snapshotUpdate.value = true
            }
        }
    }
    func openDetailController(_ data: Movies.Movie) {
        coordinatorDelegate?.openDetailController(data)
    }
}
