//
//  SearchMovieCell + Constraints.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

extension SearchMovieCell {
    func setupContraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            container.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.66),
            //
            posterImage.topAnchor.constraint(equalTo: container.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            posterImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            posterImage.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.66),
            //
            saveButton.topAnchor.constraint(equalTo: posterImage.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 32),
            saveButton.widthAnchor.constraint(equalToConstant: 24),
            //
            titleLabel.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            //
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            //
            activityIndicatorView.centerXAnchor.constraint(equalTo: posterImage.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor)
        ])
    }
}
