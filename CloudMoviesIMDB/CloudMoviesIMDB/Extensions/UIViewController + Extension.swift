//
//  UIViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit

extension UIViewController {
    func setupDismissKeyboardGesture(for searchController: UISearchController?) {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        dismissKeyboardTap.cancelsTouchesInView = false
        view.addGestureRecognizer(dismissKeyboardTap)
        if let searchController {
            searchController.obscuresBackgroundDuringPresentation = false
        }
    }
    @objc
    private func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        if let searchController = navigationItem.searchController {
            searchController.searchBar.endEditing(true)
        }
    }
}
