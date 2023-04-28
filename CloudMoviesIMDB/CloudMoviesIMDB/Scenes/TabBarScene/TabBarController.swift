//
//  TabBarController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    private func setupTabBar() {
        viewControllers = [UIViewController()]
        viewControllers = []
        tabBar.backgroundColor = .white
        tabBar.tintColor = .deepGreen
        tabBar.unselectedItemTintColor = .darkGray
    }
    deinit {
        print("TabBarController deinit")
    }
}
