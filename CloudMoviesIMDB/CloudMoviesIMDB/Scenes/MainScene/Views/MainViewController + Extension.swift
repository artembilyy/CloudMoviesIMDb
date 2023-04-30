//
//  MainViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit

extension MainViewController {
    func makeSearchController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Find from Top 250 Movies"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.autocapitalizationType = .sentences
        searchController.hidesNavigationBarDuringPresentation = true
        return searchController
    }
    func showAlert(_ errorMessage: String) {
        var dialogMessage = UIAlertController()
        var button = UIAlertAction()
        dialogMessage = UIAlertController(title: "", message: errorMessage, preferredStyle: .alert)
        button = UIAlertAction(title: "Ok", style: .default) { _ in
        }
        dialogMessage.view.tintColor = .deepGreen
        dialogMessage.addAction(button)
        present(dialogMessage, animated: true, completion: nil)
    }
    
}
