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
    lazy var titleLabel = makeLabel(font: Fonts.semiBold(.size3).font)
    lazy var descriptionLabel = makeLabel(font: Fonts.medium(.size3).font)
    lazy var saveButton = makeSaveButton(action: saveButtonAction())
    lazy var posterImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.addSubview(activityIndicatorView)
        return $0
    }(UIImageView())
    var callBack: ((Bool) -> Void)?
    /// LoadingManager
    private var imageLoadingManager: ImageLoadingManagerProtocol?
    // MARK: Init
    override init(frame: CGRect) {
        let imageCacheManager = ImageCacheManager.shared
        imageLoadingManager = ImageLoadingManager(cache: imageCacheManager)
        super.init(frame: frame)
        setup()
    }
    @available(*, unavailable)
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
        saveButton.isSelected = false
    }
    private func setup() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        container.addSubview(posterImage)
        container.addSubview(saveButton)
    }
    // MARK: - Configure
    @MainActor
    func configure(media: Movies.Movie, isSaved: Bool) {
    activityIndicatorView.startAnimating()
        Task {
            saveButton.isSelected = isSaved
            titleLabel.text = media.title
            descriptionLabel.text = "\(media.description ?? "")"
            guard let path = media.image else {
                posterImage.image = UIImage(named: "PosterNil")
                activityIndicatorView.stopAnimating()
                return
            }
            do {
                let result = try await imageLoadingManager?.getImage(from: path)
                posterImage.image = result
            } catch {
                posterImage.image = UIImage(named: "PosterNil")
            }
            activityIndicatorView.stopAnimating()
        }
    }
    @MainActor
    func configureWithData(media: FavoritesMovies, isSaved: Bool) {
    activityIndicatorView.startAnimating()
        Task {
            saveButton.isSelected = isSaved
            titleLabel.text = media.title
            descriptionLabel.text = media.overview
            guard let path = media.image else {
                posterImage.image = UIImage(named: "PosterNil")
                activityIndicatorView.stopAnimating()
                return
            }
            do {
                let result = try await imageLoadingManager?.getImage(from: path)
                posterImage.image = result
            } catch {
                posterImage.image = UIImage(named: "PosterNil")
            }
            activityIndicatorView.stopAnimating()
        }
    }
    private func saveButtonAction() -> UIAction {
        UIAction { [weak self] action in
            guard let self,
                  let buttonAction = action.sender as? UIButton else { return }
            buttonAction.isSelected.toggle()
            self.callBack?(buttonAction.isSelected)
        }
    }
}
