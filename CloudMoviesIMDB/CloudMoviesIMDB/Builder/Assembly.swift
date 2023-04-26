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
    func createSearchController(coordinatorDelegate: SearchViewModelCoordinatorDelegate) -> UIViewController
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
        let networkService = NetworkService()
        let viewModel = MainViewModel(networkService: networkService)
        let layout = UICollectionViewLayout()
        viewModel.coordinatorDelegate = coordinatorDelegate
        let viewController = MainViewController(collectionViewLayout: layout)
        viewController.viewModel = viewModel
        return viewController
    }
    func createDetailController(data: Movies.Movie) -> UIViewController {
        let viewModel = DetailViewModel(movie: data)
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
    func createSearchController(coordinatorDelegate: SearchViewModelCoordinatorDelegate) -> UIViewController {
        let networkService = NetworkService()
        let viewModel = SearchViewModel(networkService: networkService)
        let viewController = SearchViewController(viewModel: viewModel)
        return viewController
    }
}
