//
//  DetailViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    let viewModel: DetailViewModelProtocol
    lazy var detailView = DetailView()
    // MARK: - Init
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.frame = view.bounds
        detailView.configure(data: viewModel.movie)
        navigationItem.backButtonTitle = ""
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        subMainView.removeFromSuperview()
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
