//
//  SectionDetailsComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

@testable import SectionDetails
import Common
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import XCTest

final class SectionDetailsComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_SectionDetails_empty_state() {
        snapshot(
            component: SectionDetailsComponent(
                props: .init(
                    title: "Popular",
                    items: [],
                    genreById: { _ in .fakeItem() },
                    loadMoreAction: {},
                    dialog: .constant(.dismissed),
                    router: .init(routing: MockRouter<SectionDetailsRoute>())
                )
            )
        )
    }

    func test_SectionDetails_loaded_state() {
        snapshot(
            component: SectionDetailsComponent(
                props: .init(
                    title: "Popular",
                    items: Movie.testItems(count: 10),
                    genreById: { _ in .fakeItem() },
                    loadMoreAction: {},
                    dialog: .constant(.dismissed),
                    router: .init(routing: MockRouter<SectionDetailsRoute>())
                )
            )
        )
    }

    func test_SectionDetails_show_loaded_state() {
        snapshot(
            component: SectionDetailsComponent(
                props: .init(
                    title: "Top Rated Shows",
                    items: Show.testItems(count: 10),
                    genreById: { _ in .fakeItem() },
                    loadMoreAction: {},
                    dialog: .constant(.dismissed),
                    router: .init(routing: MockRouter<SectionDetailsRoute>())
                )
            )
        )
    }
}
