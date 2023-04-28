//
//  MainViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MainViewController: UICollectionViewController {
    enum MainSection: Int, CaseIterable {
        case movies
    }
    var viewModel: MainViewModelProtocol!
    var dataSource: DataSource!
    
    lazy var searchController = makeSearchController()
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
        delegate()
        setupUI()
        observe()
        setupDataSource()
        setupDismissKeyboardGesture()
        viewModel.getMovies(useCache: true)
    }
    // MARK: - Methods
    private func delegate() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
    }
    private func pullToRefresh() -> UIAction {
        UIAction { [weak self] _ in
            guard let self else { return }
            ImageCacheManager.shared.clearCache()
            URLCache.shared.removeAllCachedResponses()
            self.perfomanceUI()
            Task {
                try await Task.sleep(seconds: 1)
                self.viewModel.getMovies(useCache: false)
            }
        }
    }
    private func perfomanceUI() {
        Task {
            try await Task.sleep(seconds: 1.2)
            await MainActor.run {
                self.refreshControl.endRefreshing()
            }
        }
    }
    private func observe() {
        viewModel.fetchFinished.bind { [weak self] value in
            guard let self else { return }
            if value {
                self.viewModel.showFirst10Movies()
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
// MARK: - UI Setup
extension MainViewController {
    private func setupUI() {
        navigationItem.searchController = searchController
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        collectionView.backgroundColor = .white
        refreshControl.addAction(pullToRefresh(), for: .valueChanged)
        collectionView.register(
            MainMovieCell.self,
            forCellWithReuseIdentifier: MainMovieCell.identifier
        )
        collectionView.register(
            MainViewFooter.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: MainViewFooter.identifier
        )
        setupDataSource()
        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = dataSource
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .deepGreen
    }
}
// MARK: - Did select cell
extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.top250Movies[indexPath.item]
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.openMainSubController(movie)
    }
}
// MARK: - For paggination
//extension MainViewController {
//    override func collectionView(
//        _ collectionView: UICollectionView,
//        willDisplay cell: UICollectionViewCell,
//        forItemAt indexPath: IndexPath
//    ) {
//        let lastElement = viewModel.top250Movies.count - 1
//        if indexPath.item == lastElement {
//            isPaginating = true
//            Task {
//                try await Task.sleep(seconds: 1)
//                self.isPaginating = false
//                viewModel.addToScreen()
//            }
//        }
//    }
//}
