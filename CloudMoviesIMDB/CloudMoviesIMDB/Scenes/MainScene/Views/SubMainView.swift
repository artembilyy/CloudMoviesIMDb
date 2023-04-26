//
//  SubMainView.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class SubMainView: UIView {
    private var data: Movies.Movie?
    private var imageLoadingManager: ImageLoadingManagerProtocol
    private lazy var posterView = createPosterView()
    private lazy var mainLabel = makeLabel(text: nil, font: UIFont.setFont(name: Poppins.medium.rawValue, size: 16))
    private lazy var blur = createBlur()
    private lazy var backgroundView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    init(frame: CGRect, data: Movies.Movie) {
        imageLoadingManager = ImageLoadingManager()
        self.data = data
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
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
        backgroundView.backgroundColor = .systemPink
        backgroundView.addSubview(blur)
        backgroundView.addSubview(posterView)
        Task(priority: .userInitiated) {
            guard let path = data?.image else { return }
            let result = try await imageLoadingManager.getImage(from: path)
            posterView.image = result
            backgroundView.image = result
            guard let charactersCount = data?.title?.count else { return }
            mainLabel.text = ("Total count is \(charactersCount)")
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
            posterView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.6),
            posterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(frame.height / 7))
        ]
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 16),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        let blurConstraints = [
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.leadingAnchor.constraint(equalTo: leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(posterViewConstraints)
        NSLayoutConstraint.activate(mainLabelConstraints)
        NSLayoutConstraint.activate(blurConstraints)
        NSLayoutConstraint.activate(backgroundViewConstraints)
    }
}
