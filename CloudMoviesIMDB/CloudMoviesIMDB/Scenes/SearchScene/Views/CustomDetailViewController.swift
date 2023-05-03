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
    // MARK: - Init
    init(viewModel: CustomDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = customDetailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // MARK: - Setup
    private func configure() {
        Task {
            await viewModel.getMovieInfo()
            customDetailView.configure(data: viewModel.movie)
        }
    }
}
