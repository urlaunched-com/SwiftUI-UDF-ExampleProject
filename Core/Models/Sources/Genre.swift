//
//  Genre.swift
//  Flick
//
//  Created by Alexander Sharko on 05.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import UDF
import API
import Foundation
import SwiftFoundation

public struct Genre: Identifiable, EmptyValue {
    public struct ID: Hashable, Codable {
        public var value: Int
        
        public init(value: Int) {
            self.value = value
        }
    }

    public var id: ID
    public var name: String

    public init(
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
    public init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        name = "Pretty Little Liars"
    }
}

// MARK: - empty

extension Genre {
    public static var empty = Genre(
        id: .init(value: Int.random(in: Int.min ... 0)),
        name: ""
    )
}

// MARK: - Test

public extension Genre {
    static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        name: String = "Pretty Little Liars"
    ) -> Self {
        .init(
            id: id,
            name: name
        )
    }

    static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: $0)) }
    }

    static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: $0) }
    }
}

// MARK: - asGenre

public extension GenreRemote {
    var asGenre: Genre {
        .init(
            id: .init(value: id),
            name: name
        )
    }
}
