//
//  ReviewsSectionComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.07.2026.
//

@testable import ReviewsModule
import Common
import Foundation
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class ReviewsSectionComponentTests: BaseSnapshotTestCase {
    private var reviews: [Review] {
        Review.testItems(count: 3)
    }

    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_ReviewsSection_initial_state() {
        snapshot(
            for: ReviewsSectionComponent(props: ReviewsSectionComponent.Props(
                id: .movie(.init(value: 1)),
                reviews: reviews.map(\.id),
                reviewById: { _ in .testItem() },
                isRedacted: true,
                router: .init(routing: MockedRouting<ReviewsSectionRoute>())
            ))
        )
    }

    func test_ReviewsSection_loaded_state() {
        snapshot(
            for: ReviewsSectionComponent(props: ReviewsSectionComponent.Props(
                id: .movie(.init(value: 1)),
                reviews: reviews.map(\.id),
                reviewById: { [reviews] id in
                    reviews.first(where: { $0.id == id }) ?? .empty
                },
                isRedacted: false,
                router: .init(routing: MockedRouting<ReviewsSectionRoute>())
            ))
        )
    }
}
