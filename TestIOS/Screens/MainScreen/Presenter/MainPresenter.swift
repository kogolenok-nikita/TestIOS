//
//  MainPresenter.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import Foundation

protocol MainPresenterProtocol {
    func attachView(_ view: MainViewProtocol)
    func viewDidLoad()
}

final class MainPresenter: MainPresenterProtocol {
    private weak var view: MainViewProtocol?
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func attachView(_ view: any MainViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
    }
}
