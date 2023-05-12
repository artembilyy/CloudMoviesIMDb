//
//  FavoritesViewController + DataSource.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 12.05.2023.
//

import UIKit

extension FavoritesViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<FavoritesSection, FavoritesMovies>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoritesMovies>
    // MARK: - Diffable Data Source
    func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let section = FavoritesSection(rawValue: indexPath.section),
                  let self else { return UICollectionViewCell() }
            switch section {
            case .movies:
                guard let cell = self.collectionView.dequeueReusableCell(
                    withReuseIdentifier: SearchMovieCell.identifier,
                    for: indexPath
                ) as? SearchMovieCell else { return UICollectionViewCell() }
                guard let isSaved = self.viewModel?.checkIsFavorite(movie: item) else { return UICollectionViewCell() }
                cell.configureWithData(media: item, isSaved: isSaved)
                cell.callBack = { [weak self] isSelected in
                    guard let self else { return }
                    switch isSelected {
                    case true:
                        print("add in Future")
                    case false:
                        self.viewModel?.deleteFromFavorites(item)
                    }
                }
                return cell
            }
        }
    }
    // MARK: - Snapshot
    @MainActor
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.movies])
        guard let movies = viewModel?.favoriteMovies else { return }
        snapshot.appendItems(movies, toSection: .movies)
        dataSource.apply(snapshot)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
