//
//  SceneDelegate.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let builder = Builder()
        let router = Router(navigationController: navigationController, builder: builder, window: window)
        
        let onboardingService = OnboardingUserDefaultsService()
        if onboardingService.isOnboardingCompleted() {
            router.showMainScreen()
        } else {
            router.showOnboardingScreen()
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
