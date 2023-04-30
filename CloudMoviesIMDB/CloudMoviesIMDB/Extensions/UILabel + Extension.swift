//
//  UILabel + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

extension UILabel {
    func animate(
        newText: String,
        characterDelay: TimeInterval
    ) {
        Task {
            self.text = ""
            for (index, character) in newText.enumerated() {
                try await Task.sleep(seconds: characterDelay * Double(index))
                self.text?.append(character)
                self.fadeTransition(characterDelay)
            }
        }
    }
}
