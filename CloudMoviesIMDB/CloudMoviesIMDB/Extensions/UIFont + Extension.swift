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

enum Fonts {
    case black(_ size: FontSize)
    case blackItalic(_ size: FontSize)
    case bold(_ size: FontSize)
    case boldItalic(_ size: FontSize)
    case extraBold(_ size: FontSize)
    case extraBoldItalic(_ size: FontSize)
    case extraLight(_ size: FontSize)
    case extraLightItalic(_ size: FontSize)
    case italic(_ size: FontSize)
    case light(_ size: FontSize)
    case lightItalic(_ size: FontSize)
    case medium(_ size: FontSize)
    case mediumItalic(_ size: FontSize)
    case regular(_ size: FontSize)
    case semiBold(_ size: FontSize)
    case semiBoldItalic(_ size: FontSize)
    case thin(_ size: FontSize)
    case thinItalic(_ size: FontSize)
    var font: UIFont {
        switch self {
        case .black(let size):
            return UIFont.setFont(name: Poppins.black.rawValue, size: size.size)
        case .blackItalic(let size):
            return UIFont.setFont(name: Poppins.blackItalic.rawValue, size: size.size)
        case .bold(let size):
            return UIFont.setFont(name: Poppins.bold.rawValue, size: size.size)
        case .boldItalic(let size):
            return UIFont.setFont(name: Poppins.boldItalic.rawValue, size: size.size)
        case .extraBold(let size):
            return UIFont.setFont(name: Poppins.extraBold.rawValue, size: size.size)
        case .extraBoldItalic(let size):
            return UIFont.setFont(name: Poppins.extraBoldItalic.rawValue, size: size.size)
        case .extraLight(let size):
            return UIFont.setFont(name: Poppins.extraLight.rawValue, size: size.size)
        case .extraLightItalic(let size):
            return UIFont.setFont(name: Poppins.extraLightItalic.rawValue, size: size.size)
        case .italic(let size):
            return UIFont.setFont(name: Poppins.italic.rawValue, size: size.size)
        case .light(let size):
            return UIFont.setFont(name: Poppins.light.rawValue, size: size.size)
        case .lightItalic(let size):
            return UIFont.setFont(name: Poppins.lightItalic.rawValue, size: size.size)
        case .medium(let size):
            return UIFont.setFont(name: Poppins.medium.rawValue, size: size.size)
        case .mediumItalic(let size):
            return UIFont.setFont(name: Poppins.mediumItalic.rawValue, size: size.size)
        case .regular(let size):
            return UIFont.setFont(name: Poppins.regular.rawValue, size: size.size)
        case .semiBold(let size):
            return UIFont.setFont(name: Poppins.semiBold.rawValue, size: size.size)
        case .semiBoldItalic(let size):
            return UIFont.setFont(name: Poppins.semiBoldItalic.rawValue, size: size.size)
        case .thin(let size):
            return UIFont.setFont(name: Poppins.thin.rawValue, size: size.size)
        case .thinItalic(let size):
            return UIFont.setFont(name: Poppins.thinItalic.rawValue, size: size.size)
        }
    }
}

enum FontSize {
    case size1
    case size2
    case size3
    var size: CGFloat {
        switch self {
        case .size1: return 24.0
        case .size2: return 20.0
        case .size3: return 16.0
        }
    }
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
