//
//  SubMainView + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

extension DetailView {
    func createPosterView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = .black
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
}
