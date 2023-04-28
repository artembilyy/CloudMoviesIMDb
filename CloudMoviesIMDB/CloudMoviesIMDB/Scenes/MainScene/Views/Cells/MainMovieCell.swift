//
//  MainMovieCell.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MainMovieCell: UICollectionViewCell, IdentifiableCell {
    // MARK: - MovieCell UI Elements
    lazy var container = makeContainer()
    lazy var activityIndicatorView = makeActivityIndicatorView()
    lazy var titleLabel = makeLabel(font: UIFont.setFont(name: Poppins.semiBold.rawValue, size: 16))
    lazy var rankLabel = makeLabel(font: UIFont.setFont(name: Poppins.medium.rawValue, size: 16))
    lazy var posterImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.addSubview(activityIndicatorView)
        return $0
    }(UIImageView())
    /// LoadingManager
    private var imageLoadingManager: ImageLoadingManagerProtocol?
    // MARK: Init
    override init(frame: CGRect) {
        imageLoadingManager = ImageLoadingManager()
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContraints()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        titleLabel.text = nil
        rankLabel.text = nil
    }
    private func setup() {
        addSubview(titleLabel)
        addSubview(rankLabel)
        container.addSubview(posterImage)
    }
    // MARK: - Configure
    @MainActor
    func configure(media: Movies.Movie) {
        activityIndicatorView.showLoadingIndicator()
        Task {
            guard let path = media.image else { return }
            let result = try await imageLoadingManager?.getImage(from: path)
            posterImage.image = result
            titleLabel.text = media.title
            rankLabel.text = "Rank: \(media.rank ?? "")"
            activityIndicatorView.hideLoadingIndicator()
        }
    }
}
