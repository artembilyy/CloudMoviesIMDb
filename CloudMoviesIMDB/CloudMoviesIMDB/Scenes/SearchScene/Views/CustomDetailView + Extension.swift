//
//  CustomDetailView + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

extension CustomDetailView {
    func createPosterView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.dropShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    func createBlur() -> UIVisualEffectView {
        let blur = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }
    func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
}
