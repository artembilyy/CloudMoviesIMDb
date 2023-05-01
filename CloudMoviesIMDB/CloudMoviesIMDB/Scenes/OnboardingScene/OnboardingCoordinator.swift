//
//  OnboardingCoordinator.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class OnboardingCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var assemblyBuilder: AssemblyProtocol?
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController?
    // MARK: - Init
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol) {
        print("OnboardingCoordinator init")
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func start() {
        guard let assemblyBuilder else { return }
        let onboardingViewController = assemblyBuilder.createOnboardingController(coordinatorDelegate: self)
        navigationController?.pushViewController(onboardingViewController, animated: true)
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
