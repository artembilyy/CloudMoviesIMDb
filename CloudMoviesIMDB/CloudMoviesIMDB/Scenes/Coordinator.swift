//
//  Coordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var assemblyBuilder: AssemblyProtocol? { get }
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController? { get }
    func start()
    func didFinish()
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    func didFinish() {
        parentCoordinator?.removeChildCoordinator(self)
        childCoordinators.removeAll()
    }
}

