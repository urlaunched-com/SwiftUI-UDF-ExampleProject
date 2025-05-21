//
//  OnboardingPage.swift
//  Flick
//
//  Created by Max Kuznetsov on 15.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import DesignSystem
import Foundation
import Localizations
import SwiftUI

protocol Pageable: Identifiable where ID == Int {
    var id: Int { get }
    var title: String { get }
    var image: Image { get }
    var color: Color { get }

    var nextPage: Optional<any Pageable> { get }
}

// MARK: - Page

extension OnboardingComponent {
    struct Page: Pageable {
        var id: Int
        var title: String
        var image: Image
        var color: Color
        var nextPage: Optional<any Pageable> = nil

        static var first: Page = .init(
            id: 0,
            title: Localization.onboardingFirstPageTitle(),
            image: Image.Onboarding.first,
            color: .flOnboardOrange,
            nextPage: Page.second
        )

        static var second: Page = .init(
            id: 1,
            title: Localization.onboardingSecondPageTitle(),
            image: Image.Onboarding.second,
            color: .flOnboardYellow,
            nextPage: Page.third
        )

        static var third: Page = .init(
            id: 2,
            title: Localization.onboardingThirdPageTitle(),
            image: Image.Onboarding.third,
            color: .flOnboardBlue,
            nextPage: Page.fourth
        )

        static var fourth: Page = .init(
            id: 3,
            title: Localization.onboardingFourthPageTitle(),
            image: Image.Onboarding.fourth,
            color: .flMainPink
        )

        static var allPages: [Page] = [.first, .second, .third, .fourth]

        static func testItem(
            id: Int = Int.random(in: Int.min ..< 0),
            title: String = "Test page",
            image: Image = .Onboarding.first,
            color: Color = .flOnboardOrange,
            nextPage: (any Pageable)? = nil
        ) -> Self {
            .init(
                id: id,
                title: title,
                image: image,
                color: color,
                nextPage: nextPage
            )
        }
    }
}
