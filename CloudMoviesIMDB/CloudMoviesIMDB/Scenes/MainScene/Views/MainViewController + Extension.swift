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
    func makeNoResultsLabel() -> UILabel {
        let noResultLabel = UILabel()
        noResultLabel.text = "No results found"
        noResultLabel.isHidden = true
        noResultLabel.font = Fonts.medium(.size3).font
        noResultLabel.textAlignment = NSTextAlignment.center
        return noResultLabel
    }
    func makeScrollUpButton(action: UIAction) -> UIButton {
        let button = UIButton(type: .custom, primaryAction: action)
        button.backgroundColor = .clear
        let image = UIImage(named: "downarrow")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
