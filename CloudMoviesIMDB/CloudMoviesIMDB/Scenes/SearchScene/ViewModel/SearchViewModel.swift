//
//  SearchViewModel.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import Foundation

protocol SearchViewModelProtocol {
}
final class SearchViewModel: SearchViewModelProtocol {
    let networkService: NetworkServiceProtocol
    weak var coordinatorDelegate: SearchViewModelCoordinatorDelegate?
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

protocol SearchViewModelCoordinatorDelegate: AnyObject {
}
