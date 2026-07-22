//
//  ImageComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import Image
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class ImageComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Image_placeholder_state() {
        snapshot(
            component: ImageComponent(
                props: .init(
                    size: CGSize(width: 120, height: 180),
                    url: nil,
                    isLoaderPresented: true
                )
            )
        )
    }
}
