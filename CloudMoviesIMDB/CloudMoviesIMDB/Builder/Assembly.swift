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
    func createMainViewController(coordinatorDelegate: MainPageViewModelCoordinatorDelegate) -> UICollectionViewController
    func createMainSubViewController(data: Movies.Movie) -> UIViewController
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
    func createMainViewController(coordinatorDelegate: MainPageViewModelCoordinatorDelegate) -> UICollectionViewController {
        let networkService = NetworkService()
        let viewModel = MainViewModel(networkService: networkService)
        let layout = UICollectionViewLayout()
        viewModel.coordinatorDelegate = coordinatorDelegate
        let viewController = MainViewController(collectionViewLayout: layout)
        viewController.viewModel = viewModel
        return viewController
    }
    func createMainSubViewController(data: Movies.Movie) -> UIViewController {
        let viewModel = SubMainViewModel(movie: data)
        let viewController = SubMainViewController(viewModel: viewModel)

        return viewController
    }
}
