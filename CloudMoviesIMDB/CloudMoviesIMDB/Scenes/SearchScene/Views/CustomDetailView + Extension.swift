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
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
