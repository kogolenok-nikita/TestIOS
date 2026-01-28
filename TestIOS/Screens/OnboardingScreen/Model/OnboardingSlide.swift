//
//  OnboardingSlide.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import Foundation

struct OnboardingSlide {
    let imageName: String
    let title: String
    let description: String
}

extension OnboardingSlide {
    static let slides: [OnboardingSlide] = [
        OnboardingSlide(imageName: "img1", title: "Title1", description: "Description1 descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription"),
        OnboardingSlide(imageName: "img2", title: "Title2", description: "Description2 descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription"),
        OnboardingSlide(imageName: "img3", title: "Title3", description: "Description3 descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription"),
    ]
}
