//
//  CustomDetailView.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

final class CustomDetailView: UIView {
    private var imageLoadingManager: ImageLoadingManagerProtocol
    private lazy var posterView = createPosterView()
    private lazy var mainLabel = makeLabel(
        text: nil,
        font: UIFont.setFont(
            name: Poppins.semiBold.rawValue,
            size: 1
        ),
        color: .black,
        aligment: .left
    )
    private lazy var descriptionLabel = makeLabel(
        text: nil,
        font: UIFont.setFont(
            name: Poppins.medium.rawValue,
            size: 16),
        color: .black,
        aligment: .left
    )
    override init(frame: CGRect) {
        imageLoadingManager = ImageLoadingManager()
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    private func setup() {
        backgroundColor = .white
        addSubview(posterView)
    }
    func configure(data: SearchResult.Movie?) {
        Task(priority: .userInitiated) {
            guard let data else { return }
            guard let path = data.image else { return }
//            let result = try await imageLoadingManager.getSearchImage(from: path)
//            posterView.image = result
            descriptionLabel.text = data.description
            /// avoid whitespaces
            configureAttributedText(data: data)
        }
    }
    private func configureAttributedText(data: SearchResult.Movie) {
        let attributedText = NSMutableAttributedString(string: data.title ?? "")
        mainLabel.attributedText = attributedText
    }
    private func layout() {
        let posterViewConstraints = [
            posterView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            posterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.5)
        ]
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: posterView.topAnchor, constant: 8),
            mainLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(mainLabelConstraints)
        NSLayoutConstraint.activate(posterViewConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }
}
