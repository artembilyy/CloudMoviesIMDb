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

final class AppCoordinator: Coordinator {
    
    enum AppFlow {
        case onboarding
        case main
    }
    
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    let window: UIWindow?
    
    init(window: UIWindow?, assemblyBuilder: AssemblyProtocol) {
        self.window = window
        self.assemblyBuilder = assemblyBuilder
    }
    
    func start() {
        LocalState.hasOnboarded ?
        show(appFlow: .main) :
        show(appFlow: .onboarding)
    }
    
    func show(appFlow: AppFlow) {
        guard let assemblyBuilder = assemblyBuilder else { return }
        switch appFlow {
        case .onboarding:
            let navigationController = UINavigationController()
            let onboardingCoordinator = OnboardingCoordinator(
                navigationController: navigationController,
                assemblyBuilder: assemblyBuilder
            )
            addChildCoordinator(onboardingCoordinator)
            onboardingCoordinator.start()
            window?.rootViewController = navigationController
        case .main:
            let tabBar = assemblyBuilder.createTabBarController()
            let tabBarContollerCoordinator = TabBarCoordinator(
                tabBarController: tabBar,
                assemblyBuilder: assemblyBuilder
            )
            addChildCoordinator(tabBarContollerCoordinator)
            tabBarContollerCoordinator.start()
            window?.rootViewController = tabBarContollerCoordinator.tabBarController
        }
    }
}
