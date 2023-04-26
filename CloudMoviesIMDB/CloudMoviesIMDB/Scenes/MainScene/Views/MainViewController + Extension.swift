//
//  MainViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

extension MainViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Movies.Movie>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Movies.Movie>
    
    func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
            switch section {
            case .movies:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCell.identifier, for: indexPath) as? MediaCell else { return UICollectionViewCell() }
                cell.configure(media: item)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath) in
            guard let footerView = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MainViewFooter.identifier, for: indexPath) as? MainViewFooter else { fatalError() }
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
