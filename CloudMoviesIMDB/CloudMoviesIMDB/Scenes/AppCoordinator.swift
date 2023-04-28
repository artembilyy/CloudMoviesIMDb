//
//  AppCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    /// Scene Delegate
    var window: UIWindow? { get }
    func showMainFlow()
    func showOnboarding()
}

final class AppCoordinator: AppCoordinatorProtocol {
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    var window: UIWindow?
    // MARK: - Init
    init(window: UIWindow?, assemblyBuilder: AssemblyProtocol) {
        self.window = window
        self.assemblyBuilder = assemblyBuilder
        print("App Coordinator init")
    }
    // MARK: - Load Flow
    func start() {
        if LocalState.hasOnboarded {
            showMainFlow()
        } else {
            showOnboarding()
        }
    }
    func showMainFlow() {
        guard let assemblyBuilder else { return }
        let tabBar = assemblyBuilder.createTabBarController()
        let tabBarContollerCoordinator = TabBarCoordinator(
            tabBarController: tabBar,
            assemblyBuilder: assemblyBuilder
        )
        addChildCoordinator(tabBarContollerCoordinator)
        tabBarContollerCoordinator.start()
        window?.rootViewController = tabBarContollerCoordinator.tabBarController
    }
    func showOnboarding() {
        guard let assemblyBuilder else { return }
        let navigationController = UINavigationController()
        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController,
            assemblyBuilder: assemblyBuilder
        )
        addChildCoordinator(onboardingCoordinator)
        onboardingCoordinator.start()
        window?.rootViewController = navigationController
    }
}
