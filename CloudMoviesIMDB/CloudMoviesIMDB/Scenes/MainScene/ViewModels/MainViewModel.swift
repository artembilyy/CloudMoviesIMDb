//
//  MainViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import Foundation

protocol MainPageViewModelCoordinatorDelegate: AnyObject {
    func openMainSubControllerDelegate(_ data: Movies.Movie)
}
protocol MainViewModelProtocol {
    var top250Movies: [Movies.Movie] { get }
    var textFromSearchBar: String { get set }
    var fetchFinished: Observable<Bool?> { get }
    var snapshotUpdate: Observable<Bool?> { get }
    var errorMessage: Observable<String?> { get }
    var errorAlert: Observable<String?> { get }
    var emptyResults: Observable<Bool?> { get }
    func getMovies(useCache: Bool)
    func show10Movies(_ begin: Bool)
    func saveToFavorites(movie: Movies.Movie)
    func deleteFromFavorites(movie: Movies.Movie)
    func checkIsFavorite(movie: Movies.Movie) -> Bool
    func makeLocalSearch()
    func openMainSubController(_ data: Movies.Movie)
}

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Network
    private let networkService: TopMoviesNetworkServiceProtocol
    // MARK: - DataStorage
    private let dataStorage: FavoritesMoviesStorageProtocol
    // MARK: - Properties
    private(set) var top250Movies: [Movies.Movie] = [] {
        didSet {
            switch top250Movies.isEmpty {
            case true:
                emptyResults.value = true
            case false:
                emptyResults.value = false
            }
        }
    }
    private var allMovies: [Movies.Movie] = []
    // MARK: - Binding
    var errorMessage: Observable<String?> = Observable(nil)
    var fetchFinished: Observable<Bool?> = Observable(nil)
    var snapshotUpdate: Observable<Bool?> = Observable(nil)
    var errorAlert: Observable<String?> = Observable(nil)
    var emptyResults: Observable<Bool?> = Observable(nil)
    /// text from searcBar VC
    var textFromSearchBar: String = ""
    // paggination
    var counter: Int = 0
    // MARK: - Delegate
    weak var coordinatorDelegate: MainPageViewModelCoordinatorDelegate?
    // MARK: - Init
    init(networkService: TopMoviesNetworkServiceProtocol, dataStorage: FavoritesMoviesStorageProtocol) {
        self.networkService = networkService
        self.dataStorage = dataStorage
    }
    // MARK: - Methods
    func getMovies(useCache: Bool) {
        /// avoid duplicates
        fetchFinished.value = false
        allMovies.removeAll()
        if !top250Movies.isEmpty {
            top250Movies.removeAll()
        }
        emptyResults.value = false
        counter = 0
        snapshotUpdate.value = true
        Task {
            do {
                let result = try await networkService.getTop250Movies(useCache: useCache)
                if result.errorMessage != "" {
                    self.errorAlert.value = result.errorMessage
                }
                if let movies = result.items {
                    self.allMovies = movies
                    self.fetchFinished.value = true
                }
            } catch let error as NetworkError {
                handleError(error)
                self.fetchFinished.value = true
            }
        }
    }
    /// Pagination
    func show10Movies(_ begin: Bool) {
        if begin {
            top250Movies.removeAll()
            counter = 0
        }
        let startIndex = counter * 10
        let endIndex = (counter + 1) * 10
        if !allMovies.isEmpty {
            let next10Movies = allMovies[startIndex..<endIndex]
            top250Movies.append(contentsOf: next10Movies)
        }
        snapshotUpdate.value = true
        counter != 25 ? counter += 1 : nil
    }
    /// Search from SearchBar local
    func makeLocalSearch() {
        let filteredMovies = allMovies.filter { movie in
            guard let title = movie.title else { return false }
            return title.contains(textFromSearchBar)
        }
        top250Movies = filteredMovies
        snapshotUpdate.value = true
    }
    func saveToFavorites(movie: Movies.Movie) {
        dataStorage.saveMovie(movie)
    }
    func deleteFromFavorites(movie: Movies.Movie) {
        dataStorage.deleteMovie(movie)
    }
    func checkIsFavorite(movie: Movies.Movie) -> Bool {
        dataStorage.checkIsFavorite(movie: movie)
    }
    func openMainSubController(_ data: Movies.Movie) {
        coordinatorDelegate?.openMainSubControllerDelegate(data)
    }
    deinit {
        print("MainViewModel deinit")
    }
}
// MARK: - Error handling
extension MainViewModel {
    func handleError(_ error: NetworkError) {
        switch error {
        case .requestFailed(let description):
            self.errorAlert.value = NetworkError.requestFailed(description: description).description
        case .invalidData:
            self.errorAlert.value = NetworkError.invalidData.description
        case .responseUnsuccessful(let description):
            self.errorAlert.value = NetworkError.responseUnsuccessful(description: description).description
        case .jsonDecodingFailure(let description):
            self.errorAlert.value = NetworkError.jsonDecodingFailure(description: description).description
        case .noInternetConnection:
            self.errorAlert.value = NetworkError.noInternetConnection.description
        case .unexpectedStatusCode:
            self.errorAlert.value = NetworkError.unexpectedStatusCode.description
        case .invalidURL:
            self.errorAlert.value = NetworkError.invalidURL.description
        default:
            self.errorAlert.value = NetworkError.unknown.description
        }
    }
}
