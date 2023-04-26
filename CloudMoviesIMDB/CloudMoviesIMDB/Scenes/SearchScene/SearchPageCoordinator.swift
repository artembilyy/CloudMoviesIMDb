//
//  SearchPageCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class SearchPageCoordinator: Coordinator {
    let navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    weak var parentCoordinator: Coordinator?
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func start() {
        let mainViewController = assemblyBuilder?.createSearchController(coordinatorDelegate: self)
        guard let navigationController,
              let mainViewController else { return }
        navigationController.title = "Search"
        navigationController.setViewControllers([mainViewController], animated: true)
    }
    deinit {
        print("FirstPageCoordinator deinit")
    }
}

extension SearchPageCoordinator: SearchViewModelCoordinatorDelegate {
}
