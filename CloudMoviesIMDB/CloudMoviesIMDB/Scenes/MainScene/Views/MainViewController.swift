//
//  MainViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class MainViewController: UICollectionViewController {
    var viewModel: MainViewModelProtocol!
    var dataSource: DataSource!
    
    enum Section: Int, CaseIterable {
        case movies
    }
    var isPaginating = false
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getMovies()
        observe()
    }
    private func setupUI() {
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: MediaCell.identifier)
        collectionView.register(MainViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MainViewFooter.identifier)
        setupDataSource()
        collectionView.collectionViewLayout = createLayout()
        view.addSubview(collectionView)
        collectionView.dataSource = dataSource
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .deepGreen
    }

    private func observe() {
        viewModel.obersrver.bind { [weak self] value in
            guard let self else { return }
            if value == true {
                self.viewModel.demonstratePaggination()
                self.updateSnapshot()
            }
        }
    }
}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.top250Movies[indexPath.item]
        viewModel.openMainSubController(movie)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = viewModel.top250Movies.count - 1
        if indexPath.item == lastElement {
            isPaginating = true
            viewModel.demonstratePaggination()
            self.isPaginating = false
        }
    }
}

