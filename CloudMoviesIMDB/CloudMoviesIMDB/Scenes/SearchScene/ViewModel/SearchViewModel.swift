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
}
final class SearchViewModel: SearchViewModelProtocol {
    
    private(set) var movies: [SearchResult.Movie] = []
    // MARK: Counter
    
    var snapshotUpdate: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)

    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    
    let networkService: NetworkSearchServiceProtocol
    init(networkService: NetworkSearchServiceProtocol) {
        self.networkService = networkService
    }
    
    
    func reload() {
        movies.removeAll()
    }
    func getSearchResultsMovies(queryString: String) {
        Task {
            do {
                let result = try await self.networkService.getSearchedMovies(query: queryString)
                guard let result else { return }
                movies = result
                snapshotUpdate.value = true
            } catch {
                /// add more cathes
                print(error.localizedDescription)
            }
        }
    }
}

protocol SearchViewModelCoordinatorDelegate: AnyObject {
}
