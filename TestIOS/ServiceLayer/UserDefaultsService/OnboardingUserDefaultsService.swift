//
//  OnboardingUserDefaultsService.swift
//  TestIOS
//
//  Created by Никита Коголенок on 29.01.26.
//

import Foundation

enum OnboardingUserDefaultsKey: String {
    case hasCompletedOnboarding = "hasCompletedOnboarding"
    case currentOnboardingSlide = "currentOnboardingSlide"
}

protocol OnboardingUserDefaultsServiceProtocol {
    func setOnboardingCompleted(_ completed: Bool)
    func isOnboardingCompleted() -> Bool
    
    func setCurrentSlide(_ index: Int)
    func getCurrentSlide() -> Int
    
    func resetOnboarding()
}

final class OnboardingUserDefaultsService: OnboardingUserDefaultsServiceProtocol {
    private let defaults = UserDefaults.standard
    
    func setOnboardingCompleted(_ completed: Bool) {
        defaults.set(completed, forKey: OnboardingUserDefaultsKey.hasCompletedOnboarding.rawValue)
    }
    
    func isOnboardingCompleted() -> Bool {
        return defaults.bool(forKey: OnboardingUserDefaultsKey.hasCompletedOnboarding.rawValue)
    }
    
    func setCurrentSlide(_ index: Int) {
        defaults.set(index, forKey: OnboardingUserDefaultsKey.currentOnboardingSlide.rawValue)
    }
    
    func getCurrentSlide() -> Int {
        return defaults.integer(forKey: OnboardingUserDefaultsKey.currentOnboardingSlide.rawValue)
    }
    
    func resetOnboarding() {
        defaults.removeObject(forKey: OnboardingUserDefaultsKey.hasCompletedOnboarding.rawValue)
        defaults.removeObject(forKey: OnboardingUserDefaultsKey.currentOnboardingSlide.rawValue)
    }
}
