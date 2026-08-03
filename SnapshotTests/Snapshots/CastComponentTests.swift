//
//  CastComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.07.2026.
//

@testable import Flick
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class CastComponentTests: BaseSnapshotTestCase {
    private var castItems: [Cast] {
        Cast.testItems(count: 9)
    }

    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Cast_initial_state() {
        snapshot(
            component: CastComponent(props: CastComponent.Props(
                cast: castItems.map(\.id),
                castById: { _ in .fakeItem() },
                dialogStatus: .constant(.dismissed),
            ))
        )
    }

    func test_Cast_loaded_state() {
        snapshot(
            component: CastComponent(props: CastComponent.Props(
                cast: castItems.map(\.id),
                castById: { [castItems] id in
                    castItems.first(where: { $0.id == id }) ?? .fakeItem()
                },
                dialogStatus: .constant(.dismissed)
            ))
        )
    }
}
