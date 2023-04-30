//
//  DetailViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 26.04.2023.
//

import UIKit

final class DetailViewController: UICollectionViewController {
    enum СharacterSection: Int, CaseIterable {
        case characters
    }
    // MARK: - ViewModel
    var viewModel: DetailViewModelProtocol!
    // MARK: - Init
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        title = viewModel.movie?.title
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "def")
    }
    // MARK: - Cell configure
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "def", for: indexPath
        ) as? UICollectionViewListCell else { return UICollectionViewListCell() }
        guard let char = viewModel.charactersData?.data.keys.sorted(by: { viewModel.charactersData?.data[$0] ?? 0 > viewModel.charactersData?.data[$1] ?? 0 })[indexPath.item],
              let number = viewModel.charactersData?.data[char] else { return UICollectionViewCell() }
        let attributedString = createAttributedString(char: String(char), number: number)
        let contentConfiguration = createContentConfiguration(attributedString: attributedString)
        let backgroundConfiguration = createBackgroundConfiguration()
        cell.contentConfiguration = contentConfiguration
        cell.backgroundConfiguration = backgroundConfiguration
        return cell
    }
    // MARK: - Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.charactersData?.data.keys.count ?? 0
    }
    // MARK: - Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.cellScallingPressed()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.cellWillDisplay(Double(indexPath.item))
    }
}
// MARK: - Setup Cell
extension DetailViewController {
    private func createAttributedString(char: String, number: Int) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(
            string: "\"\(char)\", ",
            attributes: [.font: UIFont.setFont(
                name: Poppins.semiBold.rawValue,
                size: 24
            ), .foregroundColor: UIColor.black])
        let timesString = NSAttributedString(
            string: "times: ",
            attributes: [.font: UIFont.setFont(
                name: Poppins.regular.rawValue,
                size: 14
            ), .foregroundColor: UIColor.black])
        let numberString = NSAttributedString(
            string: "\(number)",
            attributes: [.font: UIFont.setFont(
                name: Poppins.medium.rawValue,
                size: 16), .foregroundColor: UIColor.red])
        attributedString.append(timesString)
        attributedString.append(numberString)
        return attributedString
    }
    private func createContentConfiguration(attributedString: NSMutableAttributedString) -> UIListContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.attributedText = attributedString
        contentConfiguration.textProperties.color = .black
        return contentConfiguration
    }
    private func createBackgroundConfiguration() -> UIBackgroundConfiguration {
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .white
        return backgroundConfiguration
    }
}
