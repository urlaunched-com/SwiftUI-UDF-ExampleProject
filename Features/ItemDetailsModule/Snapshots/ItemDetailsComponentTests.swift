//
//  ItemDetailsComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

@testable import ItemDetailsModule
import Common
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest
import SwiftFoundation

final class ItemDetailsComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_ItemDetails_movie_state() {
        snapshot(
            for: ItemDetailsComponent<MockedRouting<ItemDetailsScreenRoute>>(
                props: .init(
                    item: Movie.fakeItem(),
                    genreById: { _ in .fakeItem() },
                    dialog: .constant(.dismissed)
                )
            )
        )
    }

    func test_ItemDetails_show_state() {
        snapshot(
            for: ItemDetailsComponent<MockedRouting<ItemDetailsScreenRoute>>(
                props: .init(
                    item: Show.fakeItem(),
                    genreById: { _ in .fakeItem() },
                    dialog: .constant(.dismissed)
                )
            )
        )
    }

    func test_ItemDetails_movie_without_genres_state() {
        snapshot(
            for: ItemDetailsComponent<MockedRouting>(
                props: .init(
                    item: Movie.testItem(genreIds: []),
                    genreById: { _ in .fakeItem() },
                    dialog: .constant(.dismissed)
                )
            )
        )
    }
}
