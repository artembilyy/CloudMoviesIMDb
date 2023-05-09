//
//  AssemblyTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 03.05.2023.
//

import XCTest
@testable import CloudMoviesIMDB


final class MockAssembly: AssemblyProtocol {
    var didCallCreateOnboardingController = false
    var didCallCreateTabBarController = false
    var didCallCreateMainController = false
    var didCallCreateDetailController = false
    var didCallCreateCustomDetailController = false
    var didCallCreateSearchController = false

    func createOnboardingController(coordinatorDelegate: OnboardingViewModelCoordinatorDelegate) -> UIViewController {
        didCallCreateOnboardingController = true
        return UIViewController()
    }

    func createTabBarController() -> UITabBarController {
        didCallCreateTabBarController = true
        return UITabBarController()
    }

    func createMainController(coordinatorDelegate: MainPageViewModelCoordinatorDelegate) -> UICollectionViewController {
        didCallCreateMainController = true
        return UICollectionViewController()
    }

    func createDetailController(data: Movies.Movie) -> UIViewController {
        didCallCreateDetailController = true
        return UIViewController()
    }

    func createCustomDetailController(data: Movies.Movie) -> UIViewController {
        didCallCreateCustomDetailController = true
        return UIViewController()
    }

    func createSearchController(coordinatorDelegate: SearchViewModelCoordinatorDelegate) -> UIViewController {
        didCallCreateSearchController = true
        return UIViewController()
    }
}

final class AssemblyTests: XCTestCase {
    var assembly: MockAssembly!

    override func setUp() {
        super.setUp()
        assembly = MockAssembly()
    }

    override func tearDown() {
        assembly = nil
        super.tearDown()
    }
    
    func testCreateOnboardingController() {
        let viewController = assembly.createOnboardingController(coordinatorDelegate: MockOnboardingViewModelCoordinatorDelegate())
        XCTAssertTrue(assembly.didCallCreateOnboardingController)
        XCTAssertNotNil(viewController)
    }

    func testCreateDetailController() {
        let viewController = assembly.createDetailController(data: Movies.Movie(id: "", rank: "", title: "", fullTitle: "", year: "", genres: "", image: "", crew: "", imDBRating: "", imDBRatingCount: "", originalTitle: "", type: "", releaseDate: "", runtimeMins: "", runtimeStr: "", plot: "", plotLocal: "", plotLocalIsRtl: false, awards: "", directors: "", writers: "", stars: "", resultType: "", description: ""))
        XCTAssertTrue(assembly.didCallCreateDetailController)
        XCTAssertNotNil(viewController)
    }

    func testCreateTabBarController() {
        let viewController = assembly.createTabBarController()
        XCTAssertTrue(assembly.didCallCreateTabBarController)
        XCTAssertNotNil(viewController)
    }

    func testCreateMainController() {
        let viewController = assembly.createMainController(coordinatorDelegate: MockMainPageViewModelCoordinatorDelegate())
        XCTAssertTrue(assembly.didCallCreateMainController)
        XCTAssertNotNil(viewController)
    }


    func testCreateCustomDetailController() {
        let viewController = assembly.createCustomDetailController(data: Movies.Movie(id: "", rank: "", title: "", fullTitle: "", year: "", genres: "", image: "", crew: "", imDBRating: "", imDBRatingCount: "", originalTitle: "", type: "", releaseDate: "", runtimeMins: "", runtimeStr: "", plot: "", plotLocal: "", plotLocalIsRtl: false, awards: "", directors: "", writers: "", stars: "", resultType: "", description: ""))
        XCTAssertTrue(assembly.didCallCreateCustomDetailController)
        XCTAssertNotNil(viewController)
    }

    func testCreateSearchController() {
        let viewController = assembly.createSearchController(coordinatorDelegate: MockSearchViewModelCoordinatorDelegate())
        XCTAssertTrue(assembly.didCallCreateSearchController)
        XCTAssertNotNil(viewController)
    }
}

final class MockOnboardingViewModelCoordinatorDelegate: OnboardingViewModelCoordinatorDelegate {
    var didCallOnboardingFinished = false

    func onboardingFinished() {
        didCallOnboardingFinished = true
    }
}

final class MockMainPageViewModelCoordinatorDelegate: MainPageViewModelCoordinatorDelegate {
    var didCallOpenMainSubControllerDelegate = false

    func openMainSubControllerDelegate(_ data: CloudMoviesIMDB.Movies.Movie) {
        didCallOpenMainSubControllerDelegate = true
    }
}

final class MockSearchViewModelCoordinatorDelegate: SearchViewModelCoordinatorDelegate {
    var didCallOpenDetailController = false

    func openDetailController(_ data: CloudMoviesIMDB.Movies.Movie) {
        didCallOpenDetailController = true
    }
}
