//
//  UIViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit

extension UIViewController {
    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    @objc
    private func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        recognizer.cancelsTouchesInView = false
    }
}
