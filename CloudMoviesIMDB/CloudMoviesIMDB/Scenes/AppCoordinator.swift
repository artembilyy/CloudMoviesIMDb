//
//  AppCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
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
    init(window: UIWindow?, assemblyBuilder: AssemblyProtocol) {
        print("App Coordinator init")
        self.window = window
        self.assemblyBuilder = assemblyBuilder
    }
    func start() {
        if LocalState.hasOnboarded {
            showMainFlow()
        } else {
            showOnboarding()
        }
    }
    func showMainFlow() {
        if let assemblyBuilder {
            let tabBar = assemblyBuilder.createTabBarController()
            let tabBarContollerCoordinator = TabBarCoordinator(tabBarController: tabBar, assemblyBuilder: assemblyBuilder)
            addChildCoordinator(tabBarContollerCoordinator)
            tabBarContollerCoordinator.start()
            window?.rootViewController = tabBarContollerCoordinator.tabBarController
        }
    }
    func showOnboarding() {
        if let assemblyBuilder {
            let navigationController = UINavigationController()
            let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
            addChildCoordinator(onboardingCoordinator)
            onboardingCoordinator.start()
            window?.rootViewController = navigationController
        }
    }
}
