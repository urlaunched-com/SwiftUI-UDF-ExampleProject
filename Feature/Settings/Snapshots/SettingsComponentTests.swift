//
//  SettingsComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//


@testable import Settings
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class SettingsComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Settings_initial_state() {
        snapshot(
            component: SettingsComponent(
                props: .init(rateThisAppAction: {})
            )
        )
    }
}
