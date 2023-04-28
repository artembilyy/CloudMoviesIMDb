//
//  SearchMovieCell + Constraints.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

extension SearchMovieCell {
    func setupContraints() {
        let containerConstraints = [
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            container.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.66)
        ]
        let posterImageConstraints = [
            posterImage.topAnchor.constraint(equalTo: container.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            posterImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            posterImage.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.66)
        ]
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ]
        let activityIndicatorViewConstraints = [
            activityIndicatorView.centerXAnchor.constraint(equalTo: posterImage.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor)
        ]
        NSLayoutConstraint.activate(containerConstraints + posterImageConstraints + titleConstraints + descriptionLabelConstraints + activityIndicatorViewConstraints)
    }
}
