//
//  CastComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.07.2026.
//

@testable import Cast
import Common
import Foundation
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class CastComponentTests: BaseSnapshotTestCase {
    private var castItems: [Models.Cast] {
        Models.Cast.testItems(count: 9)
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
                router: MockRouter<CastRoute>()
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
                dialogStatus: .constant(.dismissed),
                router: MockRouter<CastRoute>()
            ))
        )
    }
}
