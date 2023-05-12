//
//  FavoritesViewController + CompositionalLayout.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 12.05.2023.
//

import UIKit

extension FavoritesViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (sectionNumber, _) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            switch sectionNumber {
            default:
                return self.createSearchMoviesLayout()
            }
        }
    }
    private func createSearchMoviesLayout() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets.bottom = 8
        item.contentInsets.top = 8
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
