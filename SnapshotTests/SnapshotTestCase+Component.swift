//
//  SnapshotTestCase+Component.swift
//  SnapshotTests
//
//  Created by Max Kuznetsov on 02.11.2022.
//

import Foundation
import SDWebImage
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

@testable import Flick

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

    func cacheImage(_ imageName: String) throws {
        let image = try XCTUnwrap(UIImage(named: imageName))

        SDImageCache.shared.store(image, forKey: imageName, toDisk: false)
        SDWebImageManager.shared.cacheKeyFilter = SDWebImageCacheKeyFilter(block: { _ in
            imageName
        })

        let exp = expectation(description: "waiting for store image")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }
}
