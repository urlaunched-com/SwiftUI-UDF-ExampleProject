//
//  HomeSectionComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import HomeSection
import Common
import Foundation
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class HomeSectionComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_HomeSection_loaded_state() {
        snapshot(
            component: HomeSectionComponent(
                props: .init(
                    section: MovieSection.nowPlaying,
                    items: Movie.testItems(count: 10),
                    genreById: { _ in .testItem() },
                    router: .init(routing: MockRouter<HomeSectionRoute>())
                )
            )
        )
    }

    func test_HomeSection_show_state() {
        snapshot(
            component: HomeSectionComponent(
                props: .init(
                    section: ShowSection.popular,
                    items: Show.testItems(count: 10),
                    genreById: { _ in .testItem() },
                    router: .init(routing: MockRouter<HomeSectionRoute>())
                )
            )
        )
    }
}
