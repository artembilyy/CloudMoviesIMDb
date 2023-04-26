//
//  MediaCell + Constrains.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

extension MediaCell {
    // MARK: - MovieCell Contraints
    func setupContraints() {
        let containerConstraints = [
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            container.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.66)
        ]
        let posterImageConstraints = [
            posterImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            posterImage.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            posterImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            posterImage.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.66),
        ]
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        let rankLabelConstraints = [
            rankLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            rankLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ]
        let activityIndicatorViewConstraints = [
            activityIndicatorView.centerXAnchor.constraint(equalTo: posterImage.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor)
        ]
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(posterImageConstraints)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(rankLabelConstraints)
        NSLayoutConstraint.activate(activityIndicatorViewConstraints)
    }
}