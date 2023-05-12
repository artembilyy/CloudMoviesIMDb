//
//  FavoritesPageCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 12.05.2023.
//

import UIKit

final class FavoritesPageCoordinator: Coordinator {
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
        let favoritesController = assemblyBuilder?.createFavoritesController()
        guard let navigationController,
              let favoritesController else { return }
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.prefersLargeTitles = true
        favoritesController.title = "Favorites"
        navigationController.setViewControllers([favoritesController], animated: true)
    }
    deinit {
        print("FavoritesPageCoordinator deinit")
    }
}
