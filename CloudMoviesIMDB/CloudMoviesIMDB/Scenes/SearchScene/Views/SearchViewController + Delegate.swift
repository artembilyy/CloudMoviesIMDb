//
//  SearchViewController + Delegate.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.reload()
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
// extension SearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//                guard let query = searchController.searchBar.text,
//                        !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
//                viewModel.getSearchResultsMovies(queryString: query)
//    }
// }
