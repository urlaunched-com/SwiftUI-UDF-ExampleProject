//
//  ReviewsComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.07.2026.
//

@testable import Reviews
import Common
import Foundation
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class ReviewsComponentTests: BaseSnapshotTestCase {
    private var reviews: [Review] {
        Review.testItems(count: 10)
    }

    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Reviews_empty_state() {
        snapshot(
            component: ReviewsComponent(props: ReviewsComponent.Props(
                reviews: [],
                reviewById: { _ in .empty },
                loadMoreAction: {},
                dialog: .constant(.dismissed),
                router: MockRouter<ReviewsRoute>()
            ))
        )
    }

    func test_Reviews_loaded_state() {
        snapshot(
            component: ReviewsComponent(props: ReviewsComponent.Props(
                reviews: reviews.map(\.id),
                reviewById: { [reviews] id in
                    reviews.first(where: { $0.id == id }) ?? .empty
                },
                loadMoreAction: {},
                dialog: .constant(.dismissed),
                router: MockRouter<ReviewsRoute>()
            ))
        )
    }

    func test_Reviews_short_list_state() {
        let reviews = Review.testItems(count: 2)
        snapshot(
            component: ReviewsComponent(props: ReviewsComponent.Props(
                reviews: reviews.map(\.id),
                reviewById: { [reviews] id in
                    reviews.first(where: { $0.id == id }) ?? .empty
                },
                loadMoreAction: {},
                dialog: .constant(.dismissed),
                router: MockRouter<ReviewsRoute>()
            ))
        )
    }
}
