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
        font: Fonts.medium(.size1).font,
        color: .black,
        aligment: .left
    )
    private lazy var genreLabel = makeLabel(
        font: Fonts.medium(.size3).font,
        color: .black,
        aligment: .left
    )
    private lazy var releaseLabel = makeLabel(
        font: Fonts.medium(.size3).font,
        color: .black,
        aligment: .left
    )
    private lazy var descriptionLabel = makeLabel(
        font: Fonts.medium(.size3).font,
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
    private let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        let imageCacheManager = ImageCacheManager.shared
        imageLoadingManager = ImageLoadingManager(cache: imageCacheManager)
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
    // MARK: - Methods Setup UI
    private func setup() {
        backgroundColor = .white
        addSubview(activityIndicator)
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
            guard let path = data?.image else {
                activityIndicator.hideLoadingIndicator()
                return
            }
            var imageInCache: Bool = false
            if let image = ImageCacheManager.shared[path] {
                backgroundView.image = image
                posterView.image = image
                imageInCache = true
            }
            if imageInCache == false {
                bringSubviewToFront(activityIndicator)
                activityIndicator.startAnimating()
                try await Task.sleep(seconds: 0.5)
            }
            guard let data else { return }
            let result = try await imageLoadingManager.getImage(from: path)
            posterView.image = result
            backgroundView.image = result
            titleLabel.text = data.title
            genreLabel.text = String(describing: data.genres ?? "")
            guard let formattedString = formattedDateFromString(
                dateString: data.releaseDate ?? "",
                withFormat: "MMM dd, yyyy"
            ) else {
                self.activityIndicator.hideLoadingIndicator()
                return
            }
            releaseLabel.text = String(describing: formattedString)
            descriptionLabel.text = String(describing: data.plot ?? "")
            activityIndicator.hideLoadingIndicator()
        }
    }
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            //
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            //
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            //
            posterView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            posterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.3),
            //
            stackView.topAnchor.constraint(equalTo: posterView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            //
            blur.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blur.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            //
            descriptionLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
}
