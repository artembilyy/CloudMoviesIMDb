//
//  TabBarTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 03.05.2023.
//

import XCTest
@testable import CloudMoviesIMDB

final class MockTabbarCoordinator: TabbarCoordinatorProtocol {
    var assemblyBuilder: AssemblyProtocol?
    
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController?
    
    var tabBarController: UITabBarController = UITabBarController()
    var childCoordinators: [Coordinator] = []
    
    func start() { }
}

final class TabbarCoordinatorTests: XCTestCase {
    var coordinator: TabbarCoordinatorProtocol!
    
    override func setUp() {
        super.setUp()
        coordinator = MockTabbarCoordinator()
    }
    
    func testTabBarControllerExists() {
        XCTAssertNotNil(coordinator.tabBarController)
    }
    
    func testChildCoordinatorsArrayIsEmpty() {
        XCTAssertTrue(coordinator.childCoordinators.isEmpty)
    }
}
