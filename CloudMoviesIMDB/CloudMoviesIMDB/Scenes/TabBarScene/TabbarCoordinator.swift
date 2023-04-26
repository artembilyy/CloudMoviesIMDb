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
//        addSecondPage()
//        addThirdPage()
//        addFourthPage()
    }
    func addFirstPage() {
        if let assemblyBuilder {
            let coordinator = MainPageCoordinator(navigationController: UINavigationController(), assemblyBuilder: assemblyBuilder)
            guard let navigation = coordinator.navigationController else { return }
            let image = UIImage(systemName: "eye")
            navigation.tabBarItem = UITabBarItem(title: "", image: image, tag: 0)
            tabBarController.viewControllers?.append(navigation)
            addChildCoordinator(coordinator)
            coordinator.start()
        }
    }
//    func addSecondPage() {
//        if let assemblyBuilder {
//            let coordinator = SecondPageCoordinator(navigationController: UINavigationController(), assemblyBuilder: assemblyBuilder)
//            guard let navigation = coordinator.navigationController else { return }
//            let image = UIImage(named: "group")
//            navigation.tabBarItem = UITabBarItem(title: "", image: image, tag: 1)
//            tabBarController.viewControllers?.append(navigation)
//            addChildCoordinator(coordinator)
//            coordinator.start()
//        }
//    }
//    func addThirdPage() {
//        if let assemblyBuilder {
//            let coordinator = ThirdPageCoordinator(navigationController: UINavigationController(), assemblyBuilder: assemblyBuilder)
//            guard let navigation = coordinator.navigationController else { return }
//            let image = UIImage(named: "transactions")
//            navigation.tabBarItem = UITabBarItem(title: "", image: image, tag: 2)
//            tabBarController.viewControllers?.append(navigation)
//            addChildCoordinator(coordinator)
//            coordinator.start()
//        }
//    }
//    func addFourthPage() {
//        if let assemblyBuilder {
//            let coordinator = AccountPageCoordinator(navigationController: UINavigationController(), assemblyBuilder: assemblyBuilder)
//            guard let navigation = coordinator.navigationController else { return }
//            let image = UIImage(named: "account")
//            navigation.tabBarItem = UITabBarItem(title: "", image: image, tag: 3)
//            tabBarController.viewControllers?.append(navigation)
//            addChildCoordinator(coordinator)
//            coordinator.start()
//        }
    func deinitViewControllers() {
        tabBarController.viewControllers = []
    }
    deinit {
        print("TabBaCoordinator deinit")
    }
}
