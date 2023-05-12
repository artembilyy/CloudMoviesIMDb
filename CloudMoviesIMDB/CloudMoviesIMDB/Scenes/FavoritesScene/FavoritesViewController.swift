//
//  FavoritesViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 12.05.2023.
//

import UIKit

final class FavoritesViewController: UICollectionViewController {
    enum FavoritesSection: Int, CaseIterable {
        case movies
    }
    
    var dataSource: DataSource!
    var viewModel: FavoritesViewModelProtocol?
    
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
        setup()
        setupDataSource()
        observer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getFavoritesMovies()
        collectionView.reloadData()
    }
    private func setup() {
        collectionView.dataSource = dataSource
        collectionView.register(
            SearchMovieCell.self,
            forCellWithReuseIdentifier: SearchMovieCell.identifier
        )
        collectionView.collectionViewLayout = createLayout()
        collectionView.dataSource = dataSource
    }
    private func observer() {
        viewModel?.dataFetched.bind { [weak self] value in
            guard let self, let value else { return }
            switch value {
            case true:
                self.applySnapshot()
            case false:
                return
            }
        }
    }
}
