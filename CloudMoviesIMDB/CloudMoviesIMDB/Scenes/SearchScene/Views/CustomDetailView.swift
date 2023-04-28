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
    private lazy var titleLabel = makeLabel(
        font: UIFont.setFont(
            name: Poppins.semiBold.rawValue,
            size: 24
        ),
        color: .black,
        aligment: .left
    )
    private lazy var genreLabel = makeLabel(
        font: UIFont.setFont(
            name: Poppins.medium.rawValue,
            size: 18),
        color: .black,
        aligment: .left
    )
    private lazy var releaseLabel = makeLabel(
        font: UIFont.setFont(
            name: Poppins.medium.rawValue,
            size: 18),
        color: .black,
        aligment: .left
    )
    private lazy var descriptionLabel = makeLabel(
        font: UIFont.setFont(
            name: Poppins.medium.rawValue,
            size: 18),
        color: .black,
        aligment: .left)
    private let stackView = UIStackView(axis: .vertical, spacing: 8, distribution: .equalSpacing)
    lazy var blur = createBlur()
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        addSubview(backgroundView)
        backgroundView.addSubview(blur)
        backgroundView.addSubview(posterView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(stackView)
        backgroundView.addSubview(descriptionLabel)
        stackView.addArrangedSubviews([titleLabel, genreLabel, releaseLabel])
    }
    @MainActor
    func configure(data: Movies.Movie?) {
        Task(priority: .userInitiated) {
            guard let data else { return }
            guard let path = data.image else { return }
            let result = try await imageLoadingManager.getImage(from: path)
            posterView.image = result
            backgroundView.image = result
            titleLabel.text = data.title
            genreLabel.text = String(describing: data.genres ?? "")
            guard let formattedString = formattedDateFromString(
                dateString: data.releaseDate ?? "",
                withFormat: "MMM dd, yyyy"
            ) else { return }
            releaseLabel.text = String(describing: formattedString)
            descriptionLabel.text = String(describing: data.plot ?? "")
        }
    }
    private func layout() {
        let backgroundViewConstraints = [
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        let posterViewConstraints = [
            posterView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            posterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.3)
        ]
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: posterView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ]
        let blurConstraints = [
            blur.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blur.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ]
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(backgroundViewConstraints)
        NSLayoutConstraint.activate(blurConstraints)
        NSLayoutConstraint.activate(posterViewConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
    }
}
