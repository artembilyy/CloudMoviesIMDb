//
//  DetailViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 28.04.2023.
//

import UIKit

extension DetailViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (sectionNumber, _) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            switch sectionNumber {
            default:
                return self.createСharactersLayout()
            }
        }
    }
    func createСharactersLayout() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .absolute(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets.bottom = 10
        item.contentInsets.top = 10
        item.contentInsets.leading = 10
        item.contentInsets.bottom = 10
        
        let flexibleSpacing = NSCollectionLayoutSpacing.flexible(10)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 2
        )
        group.interItemSpacing = flexibleSpacing
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        return section
    }
}
