//
//  BaseSnapshotTestCase.swift
//  Flick
//
//  Created by Bogdan Petkanych on 13.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUISnapshotTestCase
import XCTest
import UDF

@MainActor
class BaseSnapshotTestCase: SnapshotTestCase {
    override class func setUp() {
        deviceReference = "iPhone 17 Pro"
        osVersionReference = "26.5"
        super.setUp()
    }

    override func setUp() {
        super.setUp()
        devices = [.iPhone17Pro]
        super.setUp()
    }
}


extension SnapshotTestCase {
    func snapshot<V: Component>(
        component: V,
        precision: Float = 0.99,
        perceptualPrecision: Float = 0.98,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshot(
            for: component,
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            delayForLayout: delayForLayout,
            file: file,
            testName: testName,
            line: line
        )
    }

    func snapshot<V: Component>(
        component: V,
        size: CGSize,
        precision: Float = 0.99,
        perceptualPrecision: Float = 0.98,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshot(
            component: component,
            sizes: [size],
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            delayForLayout: delayForLayout,
            file: file,
            testName: testName,
            line: line
        )
    }

    func snapshot<V: Component>(
        component: V,
        sizes: [CGSize],
        precision: Float = 0.99,
        perceptualPrecision: Float = 0.98,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshot(
            component: component,
            sizes: sizes,
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            delayForLayout: delayForLayout,
            file: file,
            testName: testName,
            line: line
        )
    }

    func snapshotSizeThatFits<V: Component>(
        component: V,
        precision: Float = 0.99,
        perceptualPrecision: Float = 0.98,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshotSizeThatFits(
            component: component,
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            delayForLayout: delayForLayout,
            file: file,
            testName: testName,
            line: line
        )
    }
}
