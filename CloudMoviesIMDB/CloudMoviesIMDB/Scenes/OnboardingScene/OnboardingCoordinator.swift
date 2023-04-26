//
//  OnboardingCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import Foundation

import UIKit

final class OnboardingCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var assemblyBuilder: AssemblyProtocol?
    
    var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol) {
        print("OnboardingCoordinator init")
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func start() {
        if let assemblyBuilder {
            let onboardingViewController = assemblyBuilder.createOnboardingController(coordinatorDelegate: self)
            navigationController?.pushViewController(onboardingViewController, animated: true)
        }
    }
    deinit {
        print("OnboardingCoordinator deinit")
    }
}

extension OnboardingCoordinator: OnboardingViewModelCoordinatorDelegate {
    func onboardingFinished() {
        didFinish()
        parentCoordinator?.start()
    }
}
