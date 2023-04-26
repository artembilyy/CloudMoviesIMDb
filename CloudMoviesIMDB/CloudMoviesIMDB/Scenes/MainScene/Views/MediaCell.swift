//
//  MediaCell.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MediaCell: UICollectionViewCell, IdentifiableCell {
    // MARK: identifier
    // MARK: - MovieCell UI Elements
    lazy var container = makeContainer()
    lazy var activityIndicatorView = makeActivityIndicatorView()
    lazy var titleLabel = makeLabel(text: nil, font: UIFont.setFont(name: Poppins.semiBold.rawValue, size: 16))
    lazy var rankLabel = makeLabel(text: nil, font: UIFont.setFont(name: Poppins.medium.rawValue, size: 16))
    lazy var posterImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.addSubview(activityIndicatorView)
        return $0
    }(UIImageView())
    
    private var imageLoadingManager: ImageLoadingManagerProtocol?
    
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
    // MARK: - Configure
    @MainActor
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
    func showLoadingIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        posterImage.bringSubviewToFront(activityIndicatorView)
    }
    func hideLoadingIndicator() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
}
