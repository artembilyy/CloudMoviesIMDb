//
//  UIFont + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit
// MARK: - Poppins Font
enum Poppins: String {
    case black            = "Poppins-Black"
    case blackItalic      = "Poppins-BlackItalic"
    case bold             = "Poppins-Bold"
    case boldItalic       = "Poppins-BoldItalic"
    case extraBold        = "Poppins-ExtraBold"
    case extraBoldItalic  = "Poppins-ExtraBoldItalic"
    case extraLight       = "Poppins-ExtraLight"
    case extraLightItalic = "Poppins-ExtraLightItalic"
    case italic           = "Poppins-Italic"
    case light            = "Poppins-Light"
    case lightItalic      = "Poppins-LightItalic"
    case medium           = "Poppins-Medium"
    case mediumItalic     = "Poppins-MediumItalic"
    case regular          = "Poppins-Regular"
    case semiBold         = "Poppins-SemiBold"
    case semiBoldItalic   = "Poppins-SemiBoldItalic"
    case thin             = "Poppins-Thin"
    case thinItalic       = "Poppins-ThinItalic"
}

// MARK: - Func for set Custom font and size
extension UIFont {
    static func setFont(name: String, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: name, size: size) else {
            fatalError("Failed to load the Poppins font.")
        }
        let font = UIFontMetrics.default.scaledFont(for: customFont)
        return font
    }
}
