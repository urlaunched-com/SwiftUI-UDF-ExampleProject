//
//  RecommendationsComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

@testable import Recommendations
import Common
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import XCTest

final class RecommendationsComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Recommendations_empty_state() {
        snapshot(
            component: RecommendationsComponent(
                props: .init(
                    title: "Popular",
                    items: [],
                    genreById: { _ in .fakeItem() },
                    loadMoreAction: {},
                    dialog: .constant(.dismissed),
                    router: MockRouter<RecommendationsRoute>()
                )
            )
        )
    }

    func test_Recommendations_loaded_state() {
        snapshot(
            component: RecommendationsComponent(
                props: .init(
                    title: "Popular",
                    items: Movie.testItems(count: 10),
                    genreById: { _ in .fakeItem() },
                    loadMoreAction: {},
                    dialog: .constant(.dismissed),
                    router: MockRouter<RecommendationsRoute>()
                )
            )
        )
    }
}
