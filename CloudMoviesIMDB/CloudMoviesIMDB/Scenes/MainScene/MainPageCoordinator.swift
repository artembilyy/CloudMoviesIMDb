//
//  MainPageCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MainPageCoordinator: Coordinator {
    let navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    weak var parentCoordinator: Coordinator?
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func start() {
        let mainViewController = assemblyBuilder?.createMainViewController(coordinatorDelegate: self)
        guard let navigationController,
              let mainViewController else { return }
        navigationController.title = "250"
        navigationController.setViewControllers([mainViewController], animated: true)
    }
    deinit {
        print("FirstPageCoordinator deinit")
    }
}

extension MainPageCoordinator: MainPageViewModelCoordinatorDelegate {
    func openMainSubControllerDelegate(_ data: Movies.Movie) {
        let mainSubViewController = assemblyBuilder?.createMainSubViewController(data: data)
        guard let mainSubViewController else { return }
        mainSubViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mainSubViewController, animated: true)
    }
}
