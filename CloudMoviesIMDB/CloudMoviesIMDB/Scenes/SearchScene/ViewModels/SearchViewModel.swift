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
    var movies: [Movies.Movie] { get }
    var snapshotUpdate: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    func getSearchResultsMovies(queryString: String)
    func openDetailController(_ data: Movies.Movie)
    func reload()
}

final class SearchViewModel: SearchViewModelProtocol {
    
    private(set) var movies: [Movies.Movie] = []
    
    var snapshotUpdate: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    let networkService: NetworkSearchServiceProtocol
    init(networkService: NetworkSearchServiceProtocol) {
        self.networkService = networkService
    }
    func reload() {
        movies.removeAll()
        snapshotUpdate.value = true
    }
    func getSearchResultsMovies(queryString: String) {
        Task {
            do {
                let result = try await self.networkService.getSearchedMovies(query: queryString)
                self.movies = result
                snapshotUpdate.value = true
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func openDetailController(_ data: Movies.Movie) {
        coordinatorDelegate?.openDetailController(data)
    }
}
