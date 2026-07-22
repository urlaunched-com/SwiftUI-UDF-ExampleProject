//
//  CastSectionComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import XCTest
@testable import CastSection

final class CastSectionComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_CastSection_initial_state() {
        snapshot(
            component: CastSectionComponent(
                props: .init(
                    cast: [],
                    castById: { _ in .fakeItem() },
                    isRedacted: false,
                    router: MockRouter()
                )
            )
        )
    }

    func test_CastSection_loaded_state() {
        let cast = Cast.testItems(count: 6)
        snapshot(
            component: CastSectionComponent(
                props: .init(
                    cast: cast.ids,
                    castById: { id in cast.first(where: { $0.id == id }) ?? .fakeItem() },
                    isRedacted: false,
                    router: MockRouter()
                )
            )
        )
    }
}
