//
//  UIActivityIndicator + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit

extension UIActivityIndicatorView {
    func showLoadingIndicator() {
        self.isHidden = false
        self.startAnimating()
    }
    func hideLoadingIndicator() {
        self.isHidden = true
        self.stopAnimating()
    }
}
