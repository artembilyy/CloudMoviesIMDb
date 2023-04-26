//
//  OnboardingSlide.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

struct OnboardingSlide {
    let title: String
    let description: String
    let image: UIImage
}

extension OnboardingSlide {
    static let onboardingData = [
        OnboardingSlide(title: "Find Movie or TV Show", description: "Don't forget to take some yummy :)", image: UIImage(named: "onboarding1") ?? UIImage()),
        OnboardingSlide(title: "Call friends", description: "The best way to spend time together is to watch a good movie", image: UIImage(named: "onboarding2") ?? UIImage()),
        OnboardingSlide(title: "Enjoy", description: "We sync your preferences across all devices. Have a fun.", image: UIImage(named: "onboarding3") ?? UIImage())
    ]
}
