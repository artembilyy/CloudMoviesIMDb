//
//  Assembly.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createOnboardingController(coordinatorDelegate: OnboardingViewModelCoordinatorDelegate) -> UIViewController
    func createTabBarController() -> UITabBarController
    func createMainController(coordinatorDelegate: MainPageViewModelCoordinatorDelegate) -> UICollectionViewController
    func createDetailController(data: Movies.Movie) -> UIViewController
    func createCustomDetailController(data: Movies.Movie) -> UIViewController
    func createSearchController(coordinatorDelegate: SearchViewModelCoordinatorDelegate) -> UIViewController
    func createFavoritesController() -> UIViewController
}

final class Assembly: AssemblyProtocol {
    func createOnboardingController(coordinatorDelegate: OnboardingViewModelCoordinatorDelegate) -> UIViewController {
        let viewModel = OnboardingViewModel()
        viewModel.coordinatorDelegate = coordinatorDelegate
        let viewController = OnboardingViewController(viewModel: viewModel)
        return viewController
    }
    func createTabBarController() -> UITabBarController {
        TabBarController()
    }
    func createMainController(coordinatorDelegate: MainPageViewModelCoordinatorDelegate) -> UICollectionViewController {
        let networkService = MoviesService()
        let dataStorage = FavoritesMoviesStorage.shared
        let viewModel = MainViewModel(networkService: networkService, dataStorage: dataStorage)
        let layout = UICollectionViewLayout()
        viewModel.coordinatorDelegate = coordinatorDelegate
        let viewController = MainViewController(collectionViewLayout: layout)
        viewController.viewModel = viewModel
        return viewController
    }
    func createDetailController(data: Movies.Movie) -> UIViewController {
        let viewModel = DetailViewModel(movie: data)
        let layout = UICollectionViewLayout()
        let viewController = DetailViewController(collectionViewLayout: layout)
        viewController.viewModel = viewModel
        return viewController
    }
    func createCustomDetailController(data: Movies.Movie) -> UIViewController {
        let networkService = MoviesService()
        let viewModel = CustomDetailViewModel(movie: data, network: networkService)
        let viewController = CustomDetailViewController(viewModel: viewModel)
        return viewController
    }
    func createSearchController(coordinatorDelegate: SearchViewModelCoordinatorDelegate) -> UIViewController {
        let networkService = MoviesService()
        let dataStorage = FavoritesMoviesStorage.shared
        let viewModel = SearchViewModel(networkService: networkService, dataStorage: dataStorage)
        viewModel.coordinatorDelegate = coordinatorDelegate
        let viewController = SearchViewController(viewModel: viewModel)
        return viewController
    }
    func createFavoritesController() -> UIViewController {
        let dataStorage = FavoritesMoviesStorage.shared
        let viewModel = FavoritesViewModel(dataSource: dataStorage)
        let layout = UICollectionViewLayout()
        let viewController = FavoritesViewController(collectionViewLayout: layout)
        viewController.viewModel = viewModel
        return viewController
    }
}
