//
//  SnapshotTestCase+Component.swift
//  SnapshotTests
//
//  Created by Max Kuznetsov on 02.11.2022.
//

import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF

@testable import Flick

extension SnapshotTestCase {
    func snapshot<V: Component>(
        component: V,
        precision: Float = 0.99,
        perceptualPrecision: Float = 0.98,
        renderingMode: RenderingMode = .drawHierarchy(afterScreenUpdates: true),
        colorScheme: ColorScheme = .light,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshot(
            for: component,
            renderingMode: renderingMode,
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            colorScheme: colorScheme,
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
        renderingMode: RenderingMode = .drawHierarchy(afterScreenUpdates: true),
        colorScheme: ColorScheme = .light,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshot(
            for: component,
            size: size,
            renderingMode: renderingMode,
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            colorScheme: colorScheme,
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
        renderingMode: RenderingMode = .drawHierarchy(afterScreenUpdates: true),
        colorScheme: ColorScheme = .light,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshot(
            for: component,
            sizes: sizes,
            renderingMode: renderingMode,
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            colorScheme: colorScheme,
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
        renderingMode: RenderingMode = .drawHierarchy(afterScreenUpdates: true),
        colorScheme: ColorScheme = .light,
        delayForLayout: TimeInterval = 0.01,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        snapshotSizeThatFits(
            for: component,
            renderingMode: renderingMode,
            precision: precision,
            perceptualPrecision: perceptualPrecision,
            colorScheme: colorScheme,
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
