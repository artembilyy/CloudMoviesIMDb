//
//  SearchViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 27.04.2023.
//

import UIKit

extension SearchViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<SearchSection, SearchResult.SearchMovies>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SearchSection, SearchResult.SearchMovies>
    // MARK: - Diffable Data Source
    func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = SearchSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
            switch section {
            case .movies:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SearchMovieCell.identifier,
                    for: indexPath
                ) as? SearchMovieCell else { return UICollectionViewCell() }
                cell.configure(media: item)
                return cell
            }
        }
    }
    // MARK: - Snapshot
    @MainActor
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.movies])
        snapshot.appendItems(viewModel.movies, toSection: .movies)
        dataSource.apply(snapshot)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
