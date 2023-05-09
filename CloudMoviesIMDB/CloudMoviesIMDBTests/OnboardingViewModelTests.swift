//
//  OnboardingViewModelTests.swift
//  CloudMoviesIMDBTests
//
//  Created by Artem Bilyi on 03.05.2023.
//

import XCTest
@testable import CloudMoviesIMDB

final class MockOnboardingViewModel: OnboardingViewModelProtocol {
    var slides: [OnboardingSlide] = []
    var currentPage: Int = 0
    var onboardingFinishedCalled = false
    weak var coordinatorDelegate: OnboardingViewModelCoordinatorDelegate?
    
    func onboardingFinished() {
        onboardingFinishedCalled = true
        coordinatorDelegate?.onboardingFinished()
    }
}

final class OnboardingViewModelTests: XCTestCase {
    var viewModel: OnboardingViewModelProtocol!
    var delegate: MockOnboardingViewModelCoordinatorDelegate!
    
    override func setUp() {
        super.setUp()
        viewModel = MockOnboardingViewModel()
        delegate = MockOnboardingViewModelCoordinatorDelegate()
        viewModel.coordinatorDelegate = delegate
    }
    
    func testOnboardingFinished_callsDelegate() {
        viewModel.onboardingFinished()
        XCTAssertTrue(delegate.didCallOnboardingFinished)
    }
    
    func testOnboardingFinished_setsOnboardingFinishedFlag() {
        viewModel.onboardingFinished()
        XCTAssertTrue((viewModel as! MockOnboardingViewModel).onboardingFinishedCalled)
    }
}
