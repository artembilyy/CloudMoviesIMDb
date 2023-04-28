//
//  UIStackView + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit
extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 5,
                     distribution: UIStackView.Distribution = .fillEqually) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
    func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
}
