//
//  TabbarCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

protocol TabbarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get }
}

final class TabBarCoordinator: TabbarCoordinatorProtocol {
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    init(tabBarController: UITabBarController, assemblyBuilder: AssemblyProtocol) {
        print("TabBarController init")
        self.tabBarController = tabBarController
        self.assemblyBuilder = assemblyBuilder
    }
    func start() {
        addFirstPage()
        addSecondPage()
//        addThirdPage()
//        addFourthPage()
    }
    func addFirstPage() {
        if let assemblyBuilder {
            let coordinator = MainPageCoordinator(
                navigationController: UINavigationController(),
                assemblyBuilder: assemblyBuilder
            )
            guard let navigation = coordinator.navigationController else { return }
            let image = UIImage(systemName: "house.fill")?.withTintColor(.deepGreen)
            navigation.tabBarItem = UITabBarItem(title: "Home", image: image, tag: 0)
            navigation.navigationController?.navigationBar.tintColor = .deepGreen
            tabBarController.viewControllers?.append(navigation)
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
    func addSecondPage() {
        if let assemblyBuilder {
            let coordinator = SearchPageCoordinator(
                navigationController: UINavigationController(),
                assemblyBuilder: assemblyBuilder
            )
            guard let navigation = coordinator.navigationController else { return }
            let image = UIImage(systemName: "magnifyingglass")
            navigation.tabBarItem = UITabBarItem(title: "Search", image: image, tag: 1)
            tabBarController.viewControllers?.append(navigation)
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
    func deinitViewControllers() {
        tabBarController.viewControllers = []
    }
    deinit {
        print("TabBaCoordinator deinit")
    }
}
