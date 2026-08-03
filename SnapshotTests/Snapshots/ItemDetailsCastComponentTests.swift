//
//  ItemDetailsCastComponent.swift
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

final class ItemDetailsCastComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_CastSection_initial_state() {
        snapshot(
            component: ItemDetailsCastComponent(
                props: .init(
                    cast: [],
                    castById: { _ in .fakeItem() },
                    isRedacted: false,
                )
            )
        )
    }

    func test_CastSection_loaded_state() {
        let cast = Cast.testItems(count: 6)
        snapshot(
            component: ItemDetailsCastComponent(
                props: .init(
                    cast: cast.ids,
                    castById: { id in cast.first(where: { $0.id == id }) ?? .fakeItem() },
                    isRedacted: false
                )
            )
        )
    }

    func test_CastSection_redacted_state() {
        snapshot(
            component: ItemDetailsCastComponent(
                props: .init(
                    cast: Cast.testItems(count: 6).ids,
                    castById: { _ in .fakeItem() },
                    isRedacted: true,
                )
            )
        )
    }
}
