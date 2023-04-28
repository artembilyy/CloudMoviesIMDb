//
//  SearchMovieCell.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

final class SearchMovieCell: UICollectionViewCell, IdentifiableCell {
    // MARK: - MovieCell UI Elements
    lazy var container = makeContainer()
    lazy var activityIndicatorView = makeActivityIndicatorView()
    lazy var titleLabel = makeLabel(font: UIFont.setFont(name: Poppins.semiBold.rawValue, size: 16))
    lazy var descriptionLabel = makeLabel(font: UIFont.setFont(name: Poppins.medium.rawValue, size: 16))
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
        descriptionLabel.text = nil
    }
    private func setup() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        container.addSubview(posterImage)
    }
    // MARK: - Configure
    @MainActor
    func configure(media: SearchResult.SearchMovies) {
        activityIndicatorView.showLoadingIndicator()
        Task {
            titleLabel.text = media.title
            descriptionLabel.text = "\(media.description ?? "")"
            guard let path = media.image else {
                posterImage.image = UIImage(systemName: "eye")
                activityIndicatorView.hideLoadingIndicator()
                return
            }
            guard let url = URL(string: path) else {
                posterImage.image = UIImage(systemName: "eye")
                activityIndicatorView.hideLoadingIndicator()
                return
            }
            let result = try await imageLoadingManager?.getSearchImage(from: url)
            posterImage.image = result

        }
    }
}
