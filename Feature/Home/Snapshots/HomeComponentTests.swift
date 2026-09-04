//
//  HomeComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@testable import Home
import Common
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import XCTest

final class HomeComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Home_movie_state() {
        snapshot(
            component: HomeComponent(
                props: .init(
                    contentType: .constant(.movie),
                    movieSections: [.popular, .topRated],
                    showSections: ShowSection.allCases,
                    moviesForSection: { _ in Movie.testItems(count: 5) },
                    showsForSection: { _ in Show.testItems(count: 5) },
                    isMoviesRedacted: { _ in false },
                    isShowsRedacted: { _ in false },
                    dialogStatus: .constant(.dismissed),
                    router: .init(routing: MockRouter<HomeRoute>())
                )
            )
        )
    }

    func test_Home_show_state() {
        snapshot(
            component: HomeComponent(
                props: .init(
                    contentType: .constant(.show),
                    movieSections: MovieSection.allCases,
                    showSections: [.popular, .topRated],
                    moviesForSection: { _ in Movie.testItems(count: 5) },
                    showsForSection: { _ in Show.testItems(count: 5) },
                    isMoviesRedacted: { _ in false },
                    isShowsRedacted: { _ in false },
                    dialogStatus: .constant(.dismissed),
                    router: .init(routing: MockRouter<HomeRoute>())
                )
            )
        )
    }
}
