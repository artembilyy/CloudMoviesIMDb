//
//  SubMainViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class SubMainViewController: UIViewController {
    let viewModel: SubMainViewModelProtocol
    lazy var subMainView = SubMainView(frame: .zero, data: viewModel.movie)
    init(viewModel: SubMainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(subMainView)
        navigationItem.backButtonTitle = ""
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    private func setupConstraints() {
        let subMainViewConstraints = [
            subMainView.topAnchor.constraint(equalTo: view.topAnchor),
            subMainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            subMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subMainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(subMainViewConstraints)
    }
    deinit {
        print("SubMainViewController deinit")
    }
}
