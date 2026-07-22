//
//  SearchComponentTests.swift
//  SnapshotTests
//
//  Created by Bogdan Petkanych on 21.07.2026.
//

@testable import Search
import Common
import Foundation
import Models
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class SearchComponentTests: BaseSnapshotTestCase {
    private var items: [SearchItem] {
        SearchItem.testItems(count: 10)
    }

    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_Search_empty_state() {
        snapshot(
            component: SearchComponent(props: SearchComponent.Props(
                searchText: .constant(""),
                itemIds: [],
                searchItemById: { _ in .fakeItem() },
                genreById: { _ in .testItem() },
                loadMoreAction: {},
                router: MockRouter<SearchRoute>()
            ))
        )
    }

    func test_Search_no_results_state() {
        snapshot(
            component: SearchComponent(props: SearchComponent.Props(
                searchText: .constant("g"),
                itemIds: [],
                searchItemById: { _ in .fakeItem() },
                genreById: { _ in .testItem() },
                loadMoreAction: {},
                router: MockRouter<SearchRoute>()
            ))
        )
    }

    func test_Search_loaded_state() {
        snapshot(
            component: SearchComponent(props: SearchComponent.Props(
                searchText: .constant("Search text"),
                itemIds: items.map(\.id),
                searchItemById: { [items] id in
                    items.first(where: { $0.id == id }) ?? .fakeItem()
                },
                genreById: { _ in .testItem() },
                loadMoreAction: {},
                router: MockRouter<SearchRoute>()
            ))
        )
    }

    func test_Search_single_result_state() {
        let item = SearchItem.testItem()
        snapshot(
            component: SearchComponent(props: SearchComponent.Props(
                searchText: .constant("One"),
                itemIds: [item.id],
                searchItemById: { _ in item },
                genreById: { _ in .testItem() },
                loadMoreAction: {},
                router: MockRouter<SearchRoute>()
            ))
        )
    }
}
