//
//  MediaCell + Constrains.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

extension MainMovieCell {
    // MARK: - MovieCell Contraints
    func setupContraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            container.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.7),
            //
            posterImage.topAnchor.constraint(equalTo: container.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            posterImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            //
            saveButton.topAnchor.constraint(equalTo: posterImage.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 32),
            //
            titleLabel.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            //
            rankLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            rankLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            //
            activityIndicatorView.centerXAnchor.constraint(equalTo: posterImage.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor)
        ])
    }
}
