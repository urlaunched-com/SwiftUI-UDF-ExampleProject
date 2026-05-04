//
//  Genre.swift
//  Flick
//
//  Created by Alexander Sharko on 05.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation

struct Genre: Identifiable {
    struct ID: Hashable, Codable {
        var value: Int
    }

    var id: ID
    var name: String

    init(
        id: ID,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}

// MARK: - Hashable, Codable

extension Genre: Hashable, Codable {}

// MARK: - Faking

extension Genre: Faking {
    init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        name = "Pretty Little Liars"
    }
}

// MARK: - empty

extension Genre {
    static var empty = Genre(
        id: .init(value: Int.random(in: Int.min ... 0)),
        name: ""
    )
}

// MARK: - Test

extension Genre {
    public static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        name: String = "Pretty Little Liars"
    ) -> Self {
        .init(
            id: id,
            name: name
        )
    }

    public static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: $0)) }
    }

    public static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: $0) }
    }
}

// MARK: - asGenre

extension GenreRemote {
    var asGenre: Genre {
        .init(
            id: .init(value: id),
            name: name
        )
    }
}
