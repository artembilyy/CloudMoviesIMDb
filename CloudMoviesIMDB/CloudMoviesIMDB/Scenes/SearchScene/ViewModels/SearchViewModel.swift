//
//  SearchViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var movies: [SearchResult.Movie] { get }
    var snapshotUpdate: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    func getSearchResultsMovies(queryString: String)
    func openDetailController(_ data: SearchResult.Movie)
}
final class SearchViewModel: SearchViewModelProtocol {
    
    private(set) var movies: [SearchResult.Movie] = []
    
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
                movies = result
                snapshotUpdate.value = true
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func openDetailController(_ data: SearchResult.Movie) {
        coordinatorDelegate?.openDetailController(data)
    }
}

protocol SearchViewModelCoordinatorDelegate: AnyObject {
    func openDetailController(_ data: SearchResult.Movie)
}
