//
//  OnboardingViewController + Constraints.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

extension OnboardingViewController {
    func layout() {
        buttonWidthConstraint?.isActive = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            //
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 24),
            //
            button.topAnchor.constraint(equalTo: pageControl.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        if isWidth {
            buttonWidthConstraint = button.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.8)
        } else {
            buttonWidthConstraint = button.widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5)
        }
        buttonWidthConstraint?.isActive = true
    }
}
