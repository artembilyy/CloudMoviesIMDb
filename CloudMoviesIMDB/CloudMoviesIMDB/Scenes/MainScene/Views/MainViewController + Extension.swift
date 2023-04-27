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
            switch section {
            case .movies:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainMovieCell.identifier,
                    for: indexPath
                ) as? MainMovieCell else { return UICollectionViewCell() }
                cell.configure(media: item)
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
    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.movies])
        snapshot.appendItems(viewModel.top250Movies, toSection: .movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
