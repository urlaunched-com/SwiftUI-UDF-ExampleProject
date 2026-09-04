//
//  OnboardingComponentTests.swift
//  SnapshotTests
//
//  Created by Alexander Sharko on 16.11.2022.
//

@testable import Onboarding
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class OnboardingComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Onboarding_firstPage() {
        let page = OnboardingComponent.Page.testItem(
            id: 0,
            image: .Onboarding.first,
            color: .flOnboardOrange,
            nextPage: OnboardingComponent.Page.testItem()
        )
        snapshot(
            component: OnboardingComponent(
                props: .init(
                    skipAction: {}
                ),
                page: page
            )
        )
    }

    func test_Onboarding_lastPage() {
        let page = OnboardingComponent.Page.testItem(
            id: 3,
            image: .Onboarding.fourth,
            color: .flMainPink
        )
        snapshot(
            component: OnboardingComponent(
                props: .init(
                    skipAction: {}
                ),
                page: page
            )
        )
    }
}
