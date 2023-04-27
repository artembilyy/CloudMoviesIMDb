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
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
