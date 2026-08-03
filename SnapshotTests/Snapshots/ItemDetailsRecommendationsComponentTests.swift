//
//  RecommendationsComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

@testable import Flick
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class ItemDetailsRecommendationsComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }
    
    func test_RecommendationsSection_empty_state() {
        snapshot(
            component: ItemDetailsRecommendationsComponent(
                props: .init(
                    item: Movie.fakeItem(),
                    items: [],
                    isRedacted: false,
                    genreById: { _ in .fakeItem() }
                )
            )
        )
    }

    func test_RecommendationsSection_loaded_state() {
        snapshot(
            component: ItemDetailsRecommendationsComponent(
                props: .init(
                    item: Movie.fakeItem(),
                    items: Movie.testItems(count: 10),
                    isRedacted: false,
                    genreById: { _ in .fakeItem() }
                )
            )
        )
    }

    func test_RecommendationsSection_redacted_state() {
        snapshot(
            component: ItemDetailsRecommendationsComponent(
                props: .init(
                    item: Show.fakeItem(),
                    items: Show.testItems(count: 10),
                    isRedacted: true,
                    genreById: { _ in .fakeItem() }
                )
            )
        )
    }
}
