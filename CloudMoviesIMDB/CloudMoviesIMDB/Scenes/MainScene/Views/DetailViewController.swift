//
//  DetailViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    /// viewModel
    let viewModel: DetailViewModelProtocol
    /// view
    lazy var detailView = DetailView()
    // MARK: - Init
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    // MARK: - Setup
    private func setup() {
        view.addSubview(detailView)
        detailView.frame = view.bounds
        navigationItem.backButtonTitle = ""
        detailView.configure(data: viewModel.movie)
    }
    private func setupConstraints() {
        let subMainViewConstraints = [
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(subMainViewConstraints)
    }
    deinit {
        print("DetailViewController deinit")
    }
}
