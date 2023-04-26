//
//  OnboardingViewController + Extension.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

extension OnboardingViewController {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    func makePageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .white
        pageControl.currentPageIndicatorTintColor = .deepGreen
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.isUserInteractionEnabled = false
        pageControl.allowsContinuousInteraction = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }
    func makeAttributedString(fullText: String, boldText: String? = "") -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: UIFont.setFont(name: Poppins.medium.rawValue, size: 16),
                                      range: NSRange(location: 0, length: fullText.count))
        return attributedString
    }
    func makeButton(
        attributedString: NSAttributedString? = NSAttributedString(),
        action: UIAction,
        borderWidth: CGFloat = 0
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.setAttributedTitle(attributedString, for: .normal)
        button.addAction(action, for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .deepGreen
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }
}
