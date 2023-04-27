//
//  SubMainView.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class DetailView: UIView {
    private var imageLoadingManager: ImageLoadingManagerProtocol
    private lazy var posterView = createPosterView()
    private lazy var mainLabel = makeLabel(
        text: nil,
        font: UIFont.setFont(
            name: Poppins.medium.rawValue,
            size: 20
        ), color: .white, aligment: .center)
    private lazy var blur = createBlur()
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
        self.mainLabel.isHidden = true
        self.mainLabel.alpha = 0.0
        backgroundColor = .white
        addSubview(backgroundView)
        backgroundView.addSubview(blur)
        backgroundView.addSubview(posterView)
        backgroundView.addSubview(mainLabel)
        mainLabel.backgroundColor = .black
    }
    func configure(data: Movies.Movie?) {
        Task(priority: .userInitiated) {
            guard let data else { return }
            guard let path = data.image else { return }
            let result = try await imageLoadingManager.getImage(from: path)
            posterView.image = result
            backgroundView.image = result
            /// avoid whitespaces
            guard let charactersCount = data.title?
                .lowercased()
                .filter({ !$0.isWhitespace })
                .count else {
                return
            }
            let charachersString = String(charactersCount)
            configureAttributedText(count: charachersString, data: data)
        }
        UIView.animate(withDuration: 2, delay: 0.0, options: [.curveEaseInOut, .transitionCurlUp], animations: {
            self.mainLabel.isHidden = false
            self.mainLabel.alpha = 1.0
        }, completion: nil)
    }
    private func configureAttributedText(count: String, data: Movies.Movie) {
        let attributedText = NSMutableAttributedString(string: "  Characters count in the title: ")
        let charAttr = [NSAttributedString.Key.foregroundColor: UIColor.red]
        attributedText.append(NSAttributedString(string: count + "  ", attributes: charAttr))
        mainLabel.attributedText = attributedText
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
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.3),
            posterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(frame.height / 7))
        ]
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 16),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 50)
        ]
        let blurConstraints = [
            blur.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blur.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blur.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(mainLabelConstraints)
        NSLayoutConstraint.activate(backgroundViewConstraints)
        NSLayoutConstraint.activate(blurConstraints)
        NSLayoutConstraint.activate(posterViewConstraints)
    }
}
