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
    lazy var titleLabel = makeLabel(font: Fonts.semiBold(.size3).font)
    lazy var rankLabel = makeLabel(font: Fonts.medium(.size3).font)
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
        let imageCacheManager = ImageCacheManager.shared
        imageLoadingManager = ImageLoadingManager(cache: imageCacheManager)
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
            titleLabel.text = media.title
            rankLabel.text = "Rank: \(media.rank ?? "")"
            guard let path = media.image else { return }
            do {
                let result = try await imageLoadingManager?.getImage(from: path)
                posterImage.image = result
            } catch {
                posterImage.image = UIImage(named: "PosterNil")
            }
            activityIndicatorView.hideLoadingIndicator()
        }
    }
    deinit {
        print("MainMovieCell deinit")
    }
}
