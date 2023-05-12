//
//  MainViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

extension MainViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<MainSection, Movies.Movie>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MainSection, Movies.Movie>
    // MARK: - Diffable Data Source
    func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = MainSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainMovieCell.identifier,
                for: indexPath
            ) as? MainMovieCell else { return UICollectionViewCell() }
            switch section {
            case .movies:
                let inFavoriteList = self.viewModel.checkIsFavorite(movie: item)
                cell.configure(media: item, isSaved: inFavoriteList)
                cell.callBack = { [weak self] isSelected in
                    guard let self else { return }
                    switch isSelected {
                    case true:
                        self.viewModel.saveToFavorites(movie: item)
                    case false:
                        self.viewModel.deleteFromFavorites(movie: item)
                    }
                }
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { [unowned self] (_, _, indexPath) in
            guard let footerView = self.collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: MainViewFooter.identifier,
                for: indexPath
            ) as? MainViewFooter else { return UICollectionReusableView() }
            footerView.toggleLoading(isEnabled: isPaginating)
            return footerView
        }
    }
    // MARK: - Snapshot
    @MainActor
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.movies])
        snapshot.appendItems(viewModel.top250Movies, toSection: .movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
