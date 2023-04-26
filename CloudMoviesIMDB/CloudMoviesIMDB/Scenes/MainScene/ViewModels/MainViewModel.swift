//
//  MainViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var top250Movies: [Movies.Movie] { get }
    var obersrver: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    func getMovies()
    func demonstratePaggination()
    func openMainSubController(_ data: Movies.Movie)
}

final class MainViewModel: MainViewModelProtocol {
    
    private var networkService: NetworkServiceProtocol
    
    private(set) var top250Movies: [Movies.Movie] = []
    private var allMovies: [Movies.Movie] = []
    var errorMessage: Observable<String?> = Observable(nil)
    var obersrver: Observable<Bool> = Observable(false)
    weak var coordinatorDelegate: MainPageViewModelCoordinatorDelegate?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getMovies() {
        Task {
            do {
                let result = try await networkService.getTop250Movies()
                if let movies = result.items {
                    self.top250Movies = movies
                    self.obersrver.value = true
                }
            } catch {
                errorMessage.value = error.localizedDescription
                debugPrint(error.localizedDescription)
            }
        }
    }
    func demonstratePaggination() {
//        for _ in 1...10 {
//            if !allMovies.isEmpty {
//                top250Movies.append(allMovies.first!)
//                allMovies.removeFirst()
//            }
//        }
    }
    func openMainSubController(_ data: Movies.Movie) {
        coordinatorDelegate?.openMainSubControllerDelegate(data)
    }
    deinit {
        print("MainViewModel deinit")
    }
}

protocol MainPageViewModelCoordinatorDelegate: AnyObject {
    func openMainSubControllerDelegate(_ data: Movies.Movie)
}
