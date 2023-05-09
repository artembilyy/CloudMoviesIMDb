//
//  CoordinatorTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 03.05.2023.
//

import XCTest
@testable import CloudMoviesIMDB

final class MockCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController?

    var didCallStart = false
    var didCallDidFinish = false
    var didCallAddChildCoordinator = false
    var didCallRemoveChildCoordinator = false

    func start() {
        didCallStart = true
    }

    func didFinish() {
        didCallDidFinish = true
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        didCallAddChildCoordinator = true
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        didCallRemoveChildCoordinator = true
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

final class CoordinatorTests: XCTestCase {
    var coordinator: MockCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = MockCoordinator()
    }

    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }

    func testStart() {
        coordinator.start()
        XCTAssertTrue(coordinator.didCallStart)
    }

    func testDidFinish() {
        coordinator.didFinish()
        XCTAssertTrue(coordinator.didCallDidFinish)
    }

    func testAddChildCoordinator() {
        let childCoordinator = MockCoordinator()
        coordinator.addChildCoordinator(childCoordinator)
        XCTAssertTrue(coordinator.didCallAddChildCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 1)
    }

    func testRemoveChildCoordinator() {
        let childCoordinator = MockCoordinator()
        coordinator.addChildCoordinator(childCoordinator)
        coordinator.removeChildCoordinator(childCoordinator)
        XCTAssertTrue(coordinator.didCallRemoveChildCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 0)
    }
}
