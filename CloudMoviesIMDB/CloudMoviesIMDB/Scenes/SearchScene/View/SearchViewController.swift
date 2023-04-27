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
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: MediaCell.identifier)
        return collectionView
    }()
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Find best movie match"
        return search
    }()
    
    
    
    let viewModel: SearchViewModelProtocol
    // MARK: - Init
    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        setup()
        setupDataSource()
        delegate()
        observers()
        collectionView.backgroundColor = .white
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.collectionView.reloadData()
        }
    }
    
    private func delegate() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.searchTextField.delegate = self
    }
    private func setup() {
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        searchController.searchBar.keyboardType = .asciiCapable
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.autocapitalizationType = .sentences
        searchController.hidesNavigationBarDuringPresentation = false
    }
    private func observers() {
        viewModel.snapshotUpdate.bind { [weak self] value in
            guard let self else { return }
            if value {
                self.updateSnapshot()
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        viewModel.getSearchResultsMovies(queryString: query)
        print(query)
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    
}

extension SearchViewController: UITextFieldDelegate {
    
}
