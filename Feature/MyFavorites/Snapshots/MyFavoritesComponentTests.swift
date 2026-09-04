//
//  MyFavoritesComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.07.2026.
//

@testable import MyFavorites
import Common
import Foundation
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class MyFavoritesComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_MyFavorites_initial_state() {
        snapshot(
            component: MyFavoritesComponent(props: MyFavoritesComponent.Props(
                contentType: .constant(.movie),
                items: Movie.testItems(count: 3),
                genreById: { _ in .testItem() },
                loadMoreAction: {},
                isRedacted: true,
                dialog: .constant(.dismissed),
                router: .init(routing: MockRouter<MyFavoritesRoute>())
            ))
        )
    }

    func test_MyFavorites_movies_loaded_state() {
        snapshot(
            component: MyFavoritesComponent(props: MyFavoritesComponent.Props(
                contentType: .constant(.movie),
                items: Movie.testItems(count: 10),
                genreById: { _ in .testItem() },
                loadMoreAction: {},
                isRedacted: false,
                dialog: .constant(.dismissed),
                router: .init(routing: MockRouter<MyFavoritesRoute>())
            ))
        )
    }

    func test_MyFavorites_shows_loaded_state() {
        snapshot(
            component: MyFavoritesComponent(props: MyFavoritesComponent.Props(
                contentType: .constant(.show),
                items: Show.testItems(count: 10),
                genreById: { _ in .testItem() },
                loadMoreAction: {},
                isRedacted: false,
                dialog: .constant(.dismissed),
                router: .init(routing: MockRouter<MyFavoritesRoute>())
            ))
        )
    }
}
