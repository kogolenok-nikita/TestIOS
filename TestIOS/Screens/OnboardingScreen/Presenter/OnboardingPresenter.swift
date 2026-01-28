//
//  OnboardingPresenter.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import UIKit

protocol OnboardingPresenterProtocol {
    func attachView(_ view: OnboardingViewProtocol)
    var slidesCount: Int { get }
    func viewDidLoad()
    func didSelectPage(_ index: Int)
    func continueButtonTapped()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    private weak var view: OnboardingViewProtocol?
    private let router: RouterProtocol
    private let slides = OnboardingSlide.slides
    private var currentPage = 0
    
    var slidesCount: Int { slides.count }
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func attachView(_ view: any OnboardingViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        updateUI()
        view?.updateCurrentPage(0)
        view?.updateContinueButton(for: 0)
    }
    
    func didSelectPage(_ index: Int) {
        currentPage = index
        view?.updateCurrentPage(currentPage)
    }
    
    func continueButtonTapped() {
        if currentPage < slides.count - 1 {
            currentPage += 1
            view?.updateCurrentPage(currentPage)
            view?.scrollToPage(currentPage)
            view?.updateContinueButton(for: currentPage)
        } else {
            router.showMainScreen()
        }
    }
    
    private func updateUI() {
        view?.updateCurrentPage(currentPage)
        view?.updateContinueButton(for: currentPage)
    }
}
