//
//  MainViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MainViewController: UICollectionViewController {
    var viewModel: MainViewModelProtocol!
    var dataSource: DataSource!
    enum MainSection: Int, CaseIterable {
        case movies
    }
    let refreshControl = UIRefreshControl()
    var isPaginating = false
    // MARK: - Init
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getMovies()
        observe()
        setupDataSource()
    }
    private func setupUI() {
        refreshControl.tintColor = UIColor.systemRed
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        collectionView.addSubview(refreshControl)
        collectionView.backgroundColor = .white
        refreshControl.addAction(pullToRefresh(), for: .valueChanged)
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: MediaCell.identifier)
        collectionView.register(
            MainViewFooter.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: MainViewFooter.identifier
        )
        setupDataSource()
        collectionView.collectionViewLayout = createLayout()
        view.addSubview(collectionView)
        collectionView.dataSource = dataSource
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .deepGreen
    }
    private func pullToRefresh() -> UIAction {
        UIAction { [weak self] _ in
            guard let self else { return }
            self.viewModel.getMovies()
            self.perfomanceUI()
        }
    }
    private func perfomanceUI() {
        Task {
            try await Task.sleep(seconds: 2)
            await MainActor.run {
                self.refreshControl.endRefreshing()
            }
        }
    }
    private func observe() {
        viewModel.fetchFinished.bind { [weak self] value in
            guard let self else { return }
            if value {
                self.viewModel.addToScreen()
                Task {
                    await MainActor.run {
                        self.updateSnapshot()
                    }
                }
            }
        }
        viewModel.snapshotUpdate.bind { [weak self] value in
            guard let self else { return }
            if value {
                Task {
                    await MainActor.run {
                        self.updateSnapshot()
                    }
                }
            }
        }
    }
}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.top250Movies[indexPath.item]
        viewModel.openMainSubController(movie)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MainViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let lastElement = viewModel.top250Movies.count - 1
        if indexPath.item == lastElement {
            isPaginating = true
            Task {
                try await Task.sleep(seconds: 1)
                viewModel.addToScreen()
                self.isPaginating = false
            }
        }
    }
}
