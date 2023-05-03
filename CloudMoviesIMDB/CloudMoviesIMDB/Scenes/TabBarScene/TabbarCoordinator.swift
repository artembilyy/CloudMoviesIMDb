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
        addTab(.home)
        addTab(.search)
    }
    func addTab(_ tab: Tab) {
        guard let assemblyBuilder = assemblyBuilder else { return }
        let coordinator: Coordinator
        switch tab {
        case .home:
            coordinator = MainPageCoordinator(
                navigationController: UINavigationController(),
                assemblyBuilder: assemblyBuilder
            )
        case .search:
            coordinator = SearchPageCoordinator(
                navigationController: UINavigationController(),
                assemblyBuilder: assemblyBuilder
            )
        }
        guard let navigation = coordinator.navigationController else { return }
        navigation.tabBarItem = UITabBarItem(title: tab.title, image: tab.image, tag: tab.tag)
        if let navBar = navigation.navigationController?.navigationBar {
            navBar.tintColor = .deepGreen
        }
        tabBarController.viewControllers?.append(navigation)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    func deinitViewControllers() {
        tabBarController.viewControllers = []
    }
    deinit {
        print("TabBaCoordinator deinit")
    }
}

extension TabBarCoordinator {
    
    enum Tab {
        case home
        case search
        
        var title: String {
            switch self {
            case .home:
                return "Home"
            case .search:
                return "Search"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .home:
                return UIImage(systemName: "house.fill")?.withTintColor(.deepGreen)
            case .search:
                return UIImage(systemName: "magnifyingglass")
            }
        }
        
        var tag: Int {
            switch self {
            case .home:
                return 0
            case .search:
                return 1
            }
        }
    }
}
