//
//  DetailView + Constraints.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

extension DetailView {
    private func layout() {
        let backgroundViewConstraints = [
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        let posterViewConstraints = [
            posterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.3),
            posterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(frame.height / 7))
        ]
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 16),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        let blurConstraints = [
            blur.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blur.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(mainLabelConstraints)
        NSLayoutConstraint.activate(backgroundViewConstraints)
        NSLayoutConstraint.activate(blurConstraints)
        NSLayoutConstraint.activate(posterViewConstraints)
    }
}
