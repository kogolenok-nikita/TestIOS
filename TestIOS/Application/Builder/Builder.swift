//
//  Builder.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import UIKit

protocol BuilderProtocol {
    func createOnboardingScreen(router: RouterProtocol) -> UIViewController
    func createMainScreen(router: RouterProtocol) -> UIViewController
}

final class Builder: BuilderProtocol {
    func createOnboardingScreen(router: RouterProtocol) -> UIViewController {
        let view = OnboardingViewController()
        return view
    }
    
    func createMainScreen(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        return view
    }
}
