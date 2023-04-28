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
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDataSource()
        delegate()
        observers()
    }
    // MARK: - Methods
    private func delegate() {
        collectionView.delegate = self
//        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
    }
    private func setup() {
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .deepGreen
        navigationItem.searchController = searchController
        searchController.searchBar.keyboardType = .asciiCapable
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.autocapitalizationType = .sentences
        searchController.hidesNavigationBarDuringPresentation = false
    }
    // MARK: - Binding
    private func observers() {
        viewModel.snapshotUpdate.bind { [weak self] value in
            guard let self else { return }
            Task {
                await MainActor.run {
                    self.updateSnapshot()
                }
            }
        }
    }
}
// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        viewModel.getSearchResultsMovies(queryString: query)
    }
}
// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        searchController.searchBar.searchTextField.endEditing(true)
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        viewModel.openDetailController(selectedItem)
    }
}
// MARK: - Don't use this one if you haven't got PREMIUM API ACCESS :)
//extension SearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
        //        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        //        viewModel.getSearchResultsMovies(queryString: query)
//    }
//}
