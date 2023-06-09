//
//  UICollectionView + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 30.04.2023.
//

import UIKit

extension UICollectionViewCell {
    func makeSaveButton(action: UIAction) -> UIButton {
        let saveButton = UIButton(type: .custom, primaryAction: action)
        saveButton.setImage(UIImage(named: "addwatchlist"), for: .normal)
        saveButton.setImage(UIImage(named: "checkmark"), for: .selected)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }
    func cellWillDisplay(_ delay: Double) {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 0.1 * delay, options: [.curveEaseInOut], animations: {
            self.alpha = 1.0
        })
    }
    func cellScallingPressed() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
            completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
            }
        }
        )
    }
}
