//
//  OnboardingViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import Foundation

protocol OnboardingViewModelCoordinatorDelegate: AnyObject {
    func onboardingFinished()
}
protocol OnboardingViewModelProtocol {
    var slides: [OnboardingSlide] { get }
    var currentPage: Int { get }
    func onboardingFinished()
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    var slides: [OnboardingSlide] = OnboardingSlide.onboardingData
    var currentPage = 0
    
    weak var coordinatorDelegate: OnboardingViewModelCoordinatorDelegate?
    
    func onboardingFinished() {
        LocalState.hasOnboarded = true
        coordinatorDelegate?.onboardingFinished()
    }
    deinit {
        print("OnboardingViewModel deinit")
    }
}
