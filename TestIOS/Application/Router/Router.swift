//
//  Router.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get }
    var builder: BuilderProtocol { get }
    var window: UIWindow? { get set }
    func showOnboardingScreen()
    func showMainScreen()
    func popToRoot()
}

final class Router: RouterProtocol {
    let navigationController: UINavigationController
    var builder: BuilderProtocol
    weak var window: UIWindow?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol, window: UIWindow?) {
        self.navigationController = navigationController
        self.builder = builder
        self.window = window
    }
    
    func showOnboardingScreen() {
        let onboardingVC = builder.createOnboardingScreen(router: self)
        navigationController.setViewControllers([onboardingVC], animated: false)
        window?.rootViewController = navigationController
    }
    
    func showMainScreen() {
        let mainVC = builder.createMainScreen(router: self)
        navigationController.setViewControllers([mainVC], animated: false)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
