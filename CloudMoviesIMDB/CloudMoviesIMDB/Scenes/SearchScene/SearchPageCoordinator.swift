//
//  SearchPageCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class SearchPageCoordinator: NSObject, Coordinator {
    let navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    weak var parentCoordinator: Coordinator?
    // MARK: - Init
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func start() {
        let searchViewController = assemblyBuilder?.createSearchController(coordinatorDelegate: self)
        guard let navigationController,
              let searchViewController else { return }
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        searchViewController.title = "Search"
        navigationController.setViewControllers([searchViewController], animated: true)
    }
    deinit {
        print("FirstPageCoordinator deinit")
    }
}

extension SearchPageCoordinator: SearchViewModelCoordinatorDelegate {
    func openDetailController(_ data: Movies.Movie) {
        let customDetailController = assemblyBuilder?.createCustomDetailController(data: data)
        guard let customDetailController else { return }
        customDetailController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(customDetailController, animated: true)
    }
}
