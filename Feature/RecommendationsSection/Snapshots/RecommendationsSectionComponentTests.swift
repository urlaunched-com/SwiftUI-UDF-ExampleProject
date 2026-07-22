//
//  RecommendationsSectionComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

@testable import RecommendationsSection
import Common
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import XCTest

final class RecommendationsSectionComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_RecommendationsSection_empty_state() {
        snapshot(
            component: RecommendationsSectionComponent(
                props: .init(
                    item: Movie.fakeItem(),
                    items: [],
                    isRedacted: false,
                    genreById: { _ in .fakeItem() },
                    router: MockRouter<RecommendationsSectionRoute>()
                )
            )
        )
    }

    func test_RecommendationsSection_loaded_state() {
        snapshot(
            component: RecommendationsSectionComponent(
                props: .init(
                    item: Movie.fakeItem(),
                    items: Movie.testItems(count: 10),
                    isRedacted: false,
                    genreById: { _ in .fakeItem() },
                    router: MockRouter<RecommendationsSectionRoute>()
                )
            )
        )
    }
}
