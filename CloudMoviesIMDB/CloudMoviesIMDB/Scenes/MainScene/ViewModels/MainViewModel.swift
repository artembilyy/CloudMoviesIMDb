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
    var snapshotUpdate: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    func getMovies(useCache: Bool)
    func show10Movies()
    func makeLocalSearch()
    func openMainSubController(_ data: Movies.Movie)
}

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Network
    private var networkService: TopMoviesNetworkServiceProtocol
    // MARK: - Properties
    private(set) var top250Movies: [Movies.Movie] = []
    private var allMovies: [Movies.Movie] = []
    // MARK: - Binding
    var errorMessage: Observable<String?> = Observable(nil)
    var fetchFinished: Observable<Bool?> = Observable(nil)
    var snapshotUpdate: Observable<Bool> = Observable(false)
    /// text from searcBar VC
    var textFromSearchBar: String = ""
    // paggination
    var counter: Int = 0
    // MARK: - Delegate
    weak var coordinatorDelegate: MainPageViewModelCoordinatorDelegate?
    // MARK: - Init
    init(networkService: TopMoviesNetworkServiceProtocol) {
        self.networkService = networkService
    }
    // MARK: - Methods
    func getMovies(useCache: Bool) {
        /// avoid duplicates
        self.fetchFinished.value = false
        self.allMovies.removeAll()
        self.top250Movies.removeAll()
        counter = 0
        snapshotUpdate.value = true
        Task {
            do {
                let result = try await networkService.getTop250Movies(useCache: useCache)
                if let movies = result.items {
                    self.allMovies = movies
                    self.fetchFinished.value = true
                }
            } catch {
                print(error.localizedDescription)
                self.fetchFinished.value = true
            }
        }
    }
    func show10Movies() {
        let startIndex = counter * 10
        let endIndex = (counter + 1) * 10
        let next10Movies = allMovies[startIndex..<endIndex].map { $0 }
        top250Movies.append(contentsOf: next10Movies)
        snapshotUpdate.value = true
        counter != 25 ? counter += 1 : nil
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
