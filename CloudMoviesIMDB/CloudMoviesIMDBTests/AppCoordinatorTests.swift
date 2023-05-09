//
//  AppCoordinatorTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 03.05.2023.
//

import XCTest
@testable import CloudMoviesIMDB

final class MockAppCoordinator: AppCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController?
    var window: UIWindow?

    var didCallShowMainFlow = false
    var didCallShowOnboarding = false
    var didCallRemoveChildCoordinator = false

    func start() {}

    func didFinish() {}

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        didCallRemoveChildCoordinator = true
        childCoordinators.removeAll(where: { $0 === coordinator })
    }

    func showMainFlow() {
        didCallShowMainFlow = true
    }

    func showOnboarding() {
        didCallShowOnboarding = true
    }
}

final class AppCoordinatorTests: XCTestCase {
    var coordinator: MockAppCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = MockAppCoordinator()
    }

    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }

    func testShowMainFlow() {
        coordinator.showMainFlow()
        XCTAssertTrue(coordinator.didCallShowMainFlow)
    }

    func testShowOnboarding() {
        coordinator.showOnboarding()
        XCTAssertTrue(coordinator.didCallShowOnboarding)
    }

    func testRemoveChildCoordinator() {
        let childCoordinator = MockCoordinator()
        coordinator.addChildCoordinator(childCoordinator)
        coordinator.removeChildCoordinator(childCoordinator)
        XCTAssertTrue(coordinator.didCallRemoveChildCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 0)
    }
}
