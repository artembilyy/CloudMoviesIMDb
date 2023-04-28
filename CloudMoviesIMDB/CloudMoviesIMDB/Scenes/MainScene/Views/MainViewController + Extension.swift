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
}
