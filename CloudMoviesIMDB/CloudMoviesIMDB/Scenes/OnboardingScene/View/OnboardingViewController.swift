//
//  OnboardingViewController.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    let viewModel: OnboardingViewModelProtocol
    lazy var collectionView = makeCollectionView()
    lazy var pageControl = makePageControl()
    lazy var button = makeButton(attributedString: makeAttributedString(fullText: "Next"), action: action(), borderWidth: 0)
    var buttonWidthConstraint: NSLayoutConstraint?
    var isWidth = false
    var currentPage = 0 {
        didSet {
            changeUI()
        }
    }
    
    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
    private func setup() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(button)
        pageControl.numberOfPages = viewModel.slides.count
    }
    private func action() -> UIAction {
        UIAction { [weak self] _ in
            guard let self else { return }
            if self.currentPage == self.viewModel.slides.count - 1 {
                self.viewModel.onboardingFinished()
            } else {
                self.currentPage += 1
                let indexPath = IndexPath(item: self.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    private func changeUI() {
        pageControl.currentPage = currentPage
        if currentPage == viewModel.slides.count - 1 {
            let newValue = makeAttributedString(fullText: "Get Started")
            button.setAttributedTitle(newValue, for: .normal)
            isWidth = true
        } else {
            isWidth = false
            let newValue = makeAttributedString(fullText: "Next")
            button.setAttributedTitle(newValue, for: .normal)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    deinit {
        print("OnboardingViewController deinit")
    }
}
