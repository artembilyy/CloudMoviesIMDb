//
//  UIView + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//
import UIKit

extension UIView {
    func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }
    func makeLabel(text: String? = nil, font: UIFont, color: UIColor = .black, aligment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = color
        label.textAlignment = aligment
        label.numberOfLines = 0
        label.minimumContentSizeCategory = .accessibilityLarge
        label.font = font
        return label
    }
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func fadeOut(_ duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0.0
        }
    }
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
