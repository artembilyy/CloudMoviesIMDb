//
//  CustomDetailViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

final class CustomDetailViewController: UIViewController {
    let viewModel: CustomDetailViewModel
    lazy var customDetailView = CustomDetailView()
    init(viewModel: CustomDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setup()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    private func getData() {
        
    }
    // MARK: - Setup
    private func setup() {
        view.addSubview(customDetailView)
        customDetailView.frame = view.bounds
        navigationItem.backButtonTitle = ""
        customDetailView.configure(data: viewModel.movie)
    }
    private func setupConstraints() {
        let subMainViewConstraints = [
            customDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            customDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(subMainViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
