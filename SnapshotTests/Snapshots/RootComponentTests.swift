//
//  RootComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import Flick
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest
final class RootComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Root_onboarding_state() {
        snapshot(
            component: RootComponent(
                props: .init(
                    isNeedToPresentOnboarding: true,
                    selectedTab: .constant(.home),
                    homeTabPath: .constant(.init()),
                    searchTabPath: .constant(.init()),
                    randomizerTabPath: .constant(.init()),
                    favoritesTabPath: .constant(.init()),
                    profileTabPath: .constant(.init()),
                )
            )
        )
    }

    func test_Root_main_tabs_state() {
        snapshot(
            component: RootComponent(
                props: .init(
                    isNeedToPresentOnboarding: false,
                    selectedTab: .constant(.home),
                    homeTabPath: .constant(.init()),
                    searchTabPath: .constant(.init()),
                    randomizerTabPath: .constant(.init()),
                    favoritesTabPath: .constant(.init()),
                    profileTabPath: .constant(.init()),
                )
            )
        )
    }

    func test_Root_favorites_tab_state() {
        snapshot(
            component: RootComponent(
                props: .init(
                    isNeedToPresentOnboarding: false,
                    selectedTab: .constant(.favorites),
                    homeTabPath: .constant(.init()),
                    searchTabPath: .constant(.init()),
                    randomizerTabPath: .constant(.init()),
                    favoritesTabPath: .constant(.init()),
                    profileTabPath: .constant(.init()),
                )
            )
        )
    }
}
