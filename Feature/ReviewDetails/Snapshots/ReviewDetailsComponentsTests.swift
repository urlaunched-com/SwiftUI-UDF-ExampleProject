//
//  ReviewDetailsComponentsTests.swift
//  Flick
//
//  Created by Bogdan Petkanych on 19.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import ReviewDetails
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
            component: ReviewDetailsComponent(props: ReviewDetailsComponent.Props(
                id: review.id,
                reviewByID: { [self] _ in review },
                isRedacted: true,
                dialog: .constant(.dismissed),
                router: MockRouter<ReviewDetailsRoute>()
            ))
        )
    }
    
    func test_ReviewDetails_loaded_state() {
        snapshot(
            component: ReviewDetailsComponent(props: ReviewDetailsComponent.Props(
                id: review.id,
                reviewByID: { [self] _ in review },
                isRedacted: false,
                dialog: .constant(.dismissed),
                router: MockRouter<ReviewDetailsRoute>()
            ))
        )
    }
}
