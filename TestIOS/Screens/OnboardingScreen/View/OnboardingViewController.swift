//
//  OnboardingViewController.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func updateCurrentPage(_ currentPage: Int)
    func scrollToPage(_ page: Int)
    func updateContinueButton(for page: Int)
}

final class OnboardingViewController: UIViewController {
    
    // MARK: - Variable
    private let presenter: OnboardingPresenterProtocol
    
    // MARK: - GUI Variable
    private var collectionView: UICollectionView
    private let pageControl = UIPageControl()
    private let continueButton = UIButton(type: .system)
    
    // MARK: - Init
    init(presenter: OnboardingPresenterProtocol) {
        self.presenter = presenter
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
        presenter.attachView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        view.addSubview(collectionView)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = presenter.slidesCount
        pageControl.backgroundColor = .red
        view.addSubview(pageControl)
        
        continueButton.setTitle("Далее", for: .normal)
        continueButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        continueButton.backgroundColor = .systemBlue
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 12
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Action
    @objc private func continueTapped() {
        presenter.continueButtonTapped()
    }
}

// MARK: - OnboardingViewProtocol
extension OnboardingViewController: OnboardingViewProtocol {
    func updateCurrentPage(_ currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    
    func scrollToPage(_ page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func updateContinueButton(for page: Int) {
        if page == presenter.slidesCount - 1 {
            continueButton.setTitle("Начать работу", for: .normal)
        } else {
            continueButton.setTitle("Далее", for: .normal)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.slidesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        let slide = OnboardingSlide.slides[indexPath.item]
        cell.configure(with: slide)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        presenter.didSelectPage(page)
    }
}
