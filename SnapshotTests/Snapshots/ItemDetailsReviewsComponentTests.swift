//
//  ItemDetailsReviewsComponentTests.swift
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

final class ItemDetailsReviewsComponentTests: BaseSnapshotTestCase {
    private var reviews: [Review] {
        Review.testItems(count: 3)
    }

    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_ReviewsSection_initial_state() {
        snapshot(
            component: ItemDetailsReviewsComponent(
                props: .init(
                    item: Movie.testItem(),
                    reviews: reviews.ids,
                    reviewById: { [weak self] reviewID in
                        self?.reviews.first { $0.id == reviewID } ?? .empty
                    },
                    isRedacted: false,
                )
            )
        )
    }

    func test_ReviewsSection_loaded_state() {
        snapshot(
            component: ItemDetailsReviewsComponent(
                props: .init(
                    item: Movie.testItem(),
                    reviews: reviews.ids,
                    reviewById: { [weak self] reviewID in
                        self?.reviews.first { $0.id == reviewID } ?? .empty
                    },
                    isRedacted: true,
                )
            )
        )
    }
}
