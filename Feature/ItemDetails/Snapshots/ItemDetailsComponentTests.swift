//
//  ItemDetailsComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

@testable import ItemDetails
import Common
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import XCTest

final class ItemDetailsComponentTests: BaseSnapshotTestCase {
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_ItemDetails_movie_state() {
        snapshot(
            component: ItemDetailsComponent<MockRouter>(
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
            component: ItemDetailsComponent<MockRouter>(
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
            component: ItemDetailsComponent<MockRouter>(
                props: .init(
                    item: Movie.testItem(genreIds: []),
                    genreById: { _ in .fakeItem() },
                    dialog: .constant(.dismissed)
                )
            )
        )
    }
}
