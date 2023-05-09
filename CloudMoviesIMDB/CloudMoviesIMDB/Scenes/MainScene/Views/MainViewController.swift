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
    
    var searchWorkItem: DispatchWorkItem?
    // MARK: - UI
    private lazy var searchController = makeSearchController()
    private let refreshControl = UIRefreshControl()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        return indicatorView
    }()
    let noResultLabel: UILabel = {
        $0.text = "No results found"
        $0.isHidden = true
        $0.font = Fonts.medium(.size3).font
        $0.textAlignment = NSTextAlignment.center
        return $0
    }(UILabel())
    var isPaginating = false
    // MARK: - Init
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    @available(*, unavailable)
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
        setupDismissKeyboardGesture(for: searchController)
        viewModel.getMovies(useCache: true)
    }
    // MARK: - Methods
    private func delegate() {
//        searchController.searchResultsUpdater = self
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
    // MARK: - Observers
    private func observe() {
        observeFetchFinished()
        observeSnapshotUpdate()
        observeErrorAlert()
        observeEmptyResults()
    }
    private func observeFetchFinished() {
        viewModel.fetchFinished.bind { [weak self] value in
            guard let self = self, let value = value else { return }
            Task {
                await MainActor.run {
                    switch value {
                    case true:
                        self.viewModel.show10Movies(false)
                        self.activityIndicator.stopAnimating()
                        self.updateSnapshot()
                    default:
                        self.activityIndicator.startAnimating()
                    }
                }
            }
        }
    }
    private func observeSnapshotUpdate() {
        viewModel.snapshotUpdate.bind { [weak self] value in
            guard let self, let value, value else { return }
            Task {
                await MainActor.run {
                    self.updateSnapshot()
                }
            }
        }
    }
    private func observeErrorAlert() {
        viewModel.errorAlert.bind { [weak self] value in
            guard let self, let value else { return }
            Task {
                await MainActor.run {
                    self.showAlert(value)
                }
            }
        }
    }
    private func observeEmptyResults() {
        viewModel.emptyResults.bind { [weak self] value in
            guard let self, let value else { return }
            Task {
                await MainActor.run {
                    self.noResultLabel.isHidden = !value
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
        view.addSubview(activityIndicator)
        view.addSubview(noResultLabel)
        noResultLabel.frame = view.bounds
        activityIndicator.frame = view.bounds
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
extension MainViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let lastElement = viewModel.top250Movies.count - 1
        if indexPath.item == lastElement && !searchController.isActive {
            isPaginating = true
            Task {
                try await Task.sleep(seconds: 1)
                self.isPaginating = false
                viewModel.show10Movies(false)
            }
        }
    }
}
