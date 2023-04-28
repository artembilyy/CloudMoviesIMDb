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
    var fetchFinished: Observable<Bool> { get }
    var snapshotUpdate: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    func getMovies(useCache: Bool)
    func showFirst10Movies()
    func makeLocalSearch()
    func openMainSubController(_ data: Movies.Movie)
}

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Network
    private var networkService: NetworkMainServiceProtocol
    // MARK: - Properties
    private(set) var top250Movies: [Movies.Movie] = []
    private var allMovies: [Movies.Movie] = []
    var errorMessage: Observable<String?> = Observable(nil)
    var fetchFinished: Observable<Bool> = Observable(false)
    var snapshotUpdate: Observable<Bool> = Observable(false)
    
    var textFromSearchBar: String = ""
    
    weak var coordinatorDelegate: MainPageViewModelCoordinatorDelegate?
    // MARK: - Init
    init(networkService: NetworkMainServiceProtocol) {
        self.networkService = networkService
    }
    // MARK: - Methods
    func getMovies(useCache: Bool) {
        /// avoid duplicates
        self.allMovies.removeAll()
        self.top250Movies.removeAll()
        snapshotUpdate.value = true
        Task {
            do {
                let result = try await networkService.getTop250Movies(useCache: useCache)
                if let movies = result.items {
                    self.allMovies = movies
                    self.fetchFinished.value = true
                }
            } catch NetworkError.invalidURL {
                print("from catch")
            } catch NetworkError.noImage {
                print(NetworkError.noImage.describing)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func showFirst10Movies() {
        let top10Movies = allMovies.prefix(10).map { $0 }
        top250Movies = top10Movies
        snapshotUpdate.value = true
    }
    func makeLocalSearch() {
        let filteredMovies = allMovies.filter { movie in
            guard let title = movie.title else { return false }
            return title.contains(textFromSearchBar)
        }
        top250Movies = filteredMovies
        snapshotUpdate.value = true
    }
    func openMainSubController(_ data: Movies.Movie) {
        coordinatorDelegate?.openMainSubControllerDelegate(data)
    }
    deinit {
        print("MainViewModel deinit")
    }
}
