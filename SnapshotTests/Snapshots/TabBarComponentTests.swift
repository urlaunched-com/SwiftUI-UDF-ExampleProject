//
//  TabBarComponentTests.swift
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

final class TabBarComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_TabBar_visible_state() {
        snapshot(
            component: TabBarComponent(
                props: .init(
                    selectedTab: .constant(.home),
                    isHidden: .constant(false)
                )
            )
        )
    }

    func test_TabBar_hidden_state() {
        snapshot(
            component: TabBarComponent(
                props: .init(
                    selectedTab: .constant(.search),
                    isHidden: .constant(true)
                )
            )
        )
    }

    func test_TabBar_randomizer_selected_state() {
        snapshot(
            component: TabBarComponent(
                props: .init(
                    selectedTab: .constant(.randomizer),
                    isHidden: .constant(false)
                )
            )
        )
    }

    func test_TabBar_favorites_selected_state() {
        snapshot(
            component: TabBarComponent(
                props: .init(
                    selectedTab: .constant(.favorites),
                    isHidden: .constant(false)
                )
            )
        )
    }

    func test_TabBar_profile_selected_state() {
        snapshot(
            component: TabBarComponent(
                props: .init(
                    selectedTab: .constant(.profile),
                    isHidden: .constant(false)
                )
            )
        )
    }
}
