//
//  MainPageCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MainPageCoordinator: NSObject, Coordinator {
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
        let mainViewController = assemblyBuilder?.createMainController(coordinatorDelegate: self)
        guard let navigationController,
              let mainViewController else { return }
        navigationController.delegate = self
        mainViewController.title = "Top 250 Movies"
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([mainViewController], animated: true)
    }
    deinit {
        print("FirstPageCoordinator deinit")
    }
}

extension MainPageCoordinator: MainPageViewModelCoordinatorDelegate {
    func openMainSubControllerDelegate(_ data: Movies.Movie) {
        let mainSubViewController = assemblyBuilder?.createDetailController(data: data)
        guard let mainSubViewController else { return }
        mainSubViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mainSubViewController, animated: true)
    }
}

extension MainPageCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        CustomTransitionAnimator()
    }
}
