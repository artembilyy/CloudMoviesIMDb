//
//  MainViewController + Delegate.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit
// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        noResultLabel.isHidden = true
        viewModel.show10Movies(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        noResultLabel.isHidden = true
        viewModel.textFromSearchBar = query
        viewModel.makeLocalSearch()
    }
}
// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
}
// MARK: - Use care if you haven't got PREMIUM API ACCESS :)
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //        guard let query = searchController.searchBar.text,
        //        !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        //        viewModel.getSearchResultsMovies(queryString: query)
    }
}
