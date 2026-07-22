//
//  MainHomeSectionComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import MainHomeSection
import Common
import Foundation
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class MainHomeSectionComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_MainHomeSection_loaded_state() {
        snapshot(
            component: MainHomeSectionComponent(
                props: .init(
                    section: MovieSection.popular,
                    items: Movie.testItems(count: 5),
                    genreById: { _ in .testItem() },
                    router: MockRouter<MainHomeSectionRoute>()
                )
            )
        )
    }

    func test_MainHomeSection_show_state() {
        snapshot(
            component: MainHomeSectionComponent(
                props: .init(
                    section: ShowSection.popular,
                    items: Show.testItems(count: 5),
                    genreById: { _ in .testItem() },
                    router: MockRouter<MainHomeSectionRoute>()
                )
            )
        )
    }
}
