//
//  OnboardingCollectionViewCell.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class OnboardingCell: UICollectionViewCell, IdentifiableCell {
    // MARK: - UI
    private lazy var titleLabel = makeLabel(
        text: nil,
        font: UIFont.setFont(
            name: Poppins.bold.rawValue,
            size: 28
        ), color: .black, aligment: .left)
    private lazy var descriptionLabel = makeLabel(
        text: nil,
        font: UIFont.setFont(
            name: Poppins.medium.rawValue,
            size: 18
        ), color: .black, aligment: .left)
    private lazy var topImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    // MARK: - Methods
    func setup(_ slide: OnboardingSlide) {
        topImage.image = slide.image
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
    private func layout() {
        let topImageConstraints = [
            topImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: frame.height / 8),
            topImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            topImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            topImage.widthAnchor.constraint(equalTo: topImage.heightAnchor, multiplier: 1)
        ]
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(topImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }
}
