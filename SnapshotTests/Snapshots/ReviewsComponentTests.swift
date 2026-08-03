//
//  ReviewsComponentTests.swift
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
                dialogStatus: .constant(.dismissed)
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
                dialogStatus: .constant(.dismissed),
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
                dialogStatus: .constant(.dismissed),
            ))
        )
    }
}
