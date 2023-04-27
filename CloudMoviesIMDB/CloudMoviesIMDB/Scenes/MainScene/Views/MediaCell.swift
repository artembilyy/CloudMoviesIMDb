//
//  MediaCell.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MediaCell: UICollectionViewCell, IdentifiableCell {
    // MARK: - MovieCell UI Elements
    lazy var container = makeContainer()
    lazy var activityIndicatorView = makeActivityIndicatorView()
    lazy var titleLabel = makeLabel(text: nil, font: UIFont.setFont(name: Poppins.semiBold.rawValue, size: 16))
    lazy var rankLabel = makeLabel(text: nil, font: UIFont.setFont(name: Poppins.medium.rawValue, size: 16))
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
        container.addSubview(posterImage)
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
    // MARK: - Configure
    func configure(media: Movies.Movie) {
        showLoadingIndicator()
        Task(priority: .userInitiated) {
            guard let path = media.image else { return }
            let result = try await imageLoadingManager?.getImage(from: path)
            posterImage.image = result
            titleLabel.text = media.title
            rankLabel.text = "Rank: \(media.rank ?? "")"
            hideLoadingIndicator()
        }
    }
    func configure(media: SearchResult.Movie) {
        showLoadingIndicator()
        Task(priority: .userInitiated) {
            print(media)
            guard let path = media.image else { return }
            let result = try await imageLoadingManager?.getImage(from: path.absoluteString)
            print(path)
            posterImage.image = result
            titleLabel.text = media.title
            rankLabel.text = "Rank: \(media.title ?? "")
            hideLoadingIndicator()
            print(media.title)
        }
    }
    private func showLoadingIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        posterImage.bringSubviewToFront(activityIndicatorView)
    }
    private func hideLoadingIndicator() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
}
