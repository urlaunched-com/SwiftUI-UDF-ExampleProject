//
//  BaseSnapshotTestCase.swift
//  Flick
//
//  Created by Bogdan Petkanych on 13.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUISnapshotTestCase
import XCTest

@MainActor
class BaseSnapshotTestCase: SnapshotTestCase {
    override class func setUp() {
        deviceReference = "iPhone 18 Pro"
        osVersionReference = "27.0"
        super.setUp()
    }

    override func setUp() {
        devices = [.iPhone18Pro]
        super.setUp()
    }
}
