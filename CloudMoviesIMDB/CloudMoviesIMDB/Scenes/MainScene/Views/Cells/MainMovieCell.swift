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
    lazy var yearLabel = makeLabel(font: Fonts.regular(.size3).font)
    lazy var rankLabel = makeLabel(font: Fonts.medium(.size3).font)
    lazy var posterImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.addSubview(activityIndicatorView)
        return $0
    }(UIImageView())
    lazy var saveButton = makeSaveButton(action: saveButtonAction())
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
        yearLabel.text = nil
        rankLabel.text = nil
        saveButton.isSelected = false
    }
    private func setup() {
        addSubview(titleLabel)
        addSubview(yearLabel)
        addSubview(rankLabel)
        container.addSubview(posterImage)
        container.addSubview(saveButton)
    }
    // MARK: - Configure
    @MainActor
    func configure(media: Movies.Movie, isSaved: Bool) {
        activityIndicatorView.startAnimating()
        Task {
            dump(media)
            titleLabel.text = media.title
            saveButton.isSelected = isSaved
            yearLabel.text = "Year: \(media.year ?? "Unknown")"
            rankLabel.text = "Rank: \(media.rank ?? "")"
            guard let path = media.image else { return }
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
    deinit {
        print("MainMovieCell deinit")
    }
}
