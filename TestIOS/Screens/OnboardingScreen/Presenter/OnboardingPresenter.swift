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
    var continueButtonTitle: String { get }
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    private weak var view: OnboardingViewProtocol?
    private let router: RouterProtocol
    private let userDefaultsService: OnboardingUserDefaultsServiceProtocol
    private let slides = OnboardingSlide.slides
    private var currentPage = 0
    
    var slidesCount: Int { slides.count }
    
    var continueButtonTitle: String {
        return currentPage == slides.count - 1 ? "Начать работу" : "Далее"
    }
    
    init(router: RouterProtocol, userDefaultsService: OnboardingUserDefaultsServiceProtocol) {
        self.router = router
        self.userDefaultsService = userDefaultsService
        self.currentPage = userDefaultsService.getCurrentSlide()
    }
    
    func attachView(_ view: any OnboardingViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        updateUI()
        view?.updateCurrentPage(0)
        view?.updateContinueButton(title: continueButtonTitle)
        saveCurrentPage()
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
            view?.updateContinueButton(title: continueButtonTitle)
            saveCurrentPage()
        } else {
            userDefaultsService.setOnboardingCompleted(true)
            router.showMainScreen()
        }
    }
    
    private func updateUI() {
        view?.updateCurrentPage(currentPage)
        view?.updateContinueButton(title: continueButtonTitle)
    }
    
    private func saveCurrentPage() {
        userDefaultsService.setCurrentSlide(currentPage)
    }
}
