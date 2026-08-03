//
//  ReviewDetailsComponentsTests.swift
//  Flick
//
//  Created by Bogdan Petkanych on 19.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import Flick
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

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
                review: review
            ))
        )
    }
}
