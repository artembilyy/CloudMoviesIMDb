//
//  AssemblyBuilderTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 30.04.2023.
//

import XCTest
@testable import CloudMoviesIMDB

final class AssemblyBuilderTests: XCTestCase {
    
    var assembly: AssemblyProtocol!
    
    override func setUp() {
        super.setUp()
        assembly = Assembly()
    }
    
    override func tearDown() {
        assembly = nil
        super.tearDown()
    }
    func testCreateTabBarController() {
        // When
        let tabBarController = assembly.createTabBarController()
        // Then
        XCTAssertEqual(tabBarController.viewControllers?.count, 0)
    }
    class MockOnboardingViewModelCoordinatorDelegate: OnboardingViewModelCoordinatorDelegate {
        var didCallOnboardingCompleted = false
        func onboardingFinished() {
            print("?")
        }
    }
    func testCreateOnboarding() {
        let mock = MockOnboardingViewModelCoordinatorDelegate()
        let _ = assembly.createOnboardingController(coordinatorDelegate: mock)
        XCTAssertFalse(mock.didCallOnboardingCompleted)
    }
}
