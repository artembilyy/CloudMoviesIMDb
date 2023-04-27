//
//  MediaCell + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

extension MainMovieCell {
    func makeContainer() -> UIView {
        let container = UIView()
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        container.contentMode = .scaleAspectFill
        container.backgroundColor = .white
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.layer.cornerRadius = 8
        container.dropShadow()
        addSubview(container)
        return container
    }
}
