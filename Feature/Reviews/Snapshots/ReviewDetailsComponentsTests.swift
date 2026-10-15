//
//  ReviewDetailsComponentsTests.swift
//  Flick
//
//  Created by Bogdan Petkanych on 19.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import Reviews
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest
import Common
import Models

final class ReviewDetailsComponentsTests: BaseSnapshotTestCase {
    var review: Review {
        .testItem()
    }
    
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_ReviewDetails_initial_state() {
        snapshot(
            for: ReviewDetailsComponent(props: ReviewDetailsComponent.Props(
                id: review.id,
                reviewByID: { [self] _ in review },
                isRedacted: true,
                dialog: .constant(.dismissed),
                router: .init(routing: MockedRouting<ReviewDetailsRoute>())
            ))
        )
    }
    
    func test_ReviewDetails_loaded_state() {
        snapshot(
            for: ReviewDetailsComponent(props: ReviewDetailsComponent.Props(
                id: review.id,
                reviewByID: { [self] _ in review },
                isRedacted: false,
                dialog: .constant(.dismissed),
                router: .init(routing: MockedRouting<ReviewDetailsRoute>())
            ))
        )
    }
}
