//
//  SearchViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    enum SearchSection: Int, CaseIterable {
        case movies
    }
    var dataSource: DataSource!
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(SearchMovieCell.self, forCellWithReuseIdentifier: SearchMovieCell.identifier)
        return collectionView
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        return indicatorView
    }()
    private let noResultLabel: UILabel = {
        $0.text = "No results found"
        $0.isHidden = true
        $0.font = Fonts.medium(.size3).font
        $0.textAlignment = NSTextAlignment.center
        return $0
    }(UILabel())
    let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Find best movie match"
        return search
    }()
    let viewModel: SearchViewModelProtocol
    //
    var searchWorkItem: DispatchWorkItem?
    // MARK: - Init
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDataSource()
        delegate()
        observers()
        setupDismissKeyboardGesture(for: searchController)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    // MARK: - Methods
    private func delegate() {
        collectionView.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
    }
    private func setup() {
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .deepGreen
        navigationItem.searchController = searchController
        noResultLabel.frame = collectionView.bounds
        view.addSubview(noResultLabel)
        collectionView.dataSource = dataSource
    }
    // MARK: - Binding
    private func observers() {
        viewModel.snapshotUpdate.bind { [weak self] value in
            guard let self, let value else { return }
            Task {
                await MainActor.run {
                    switch value {
                    case true:
                        self.applySnapshot()
                        self.activityIndicator.stopAnimating()
                        if self.viewModel.movies.isEmpty {
                            self.noResultLabel.isHidden = false
                        }
                    case false:
                        self.noResultLabel.isHidden = true
                        self.activityIndicator.startAnimating()
                    }
                }
            }
        }
    }
}
