//
//  Network.swift
//  Flick
//
//  Created by Alexander Sharko on 18.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation

struct Network: Identifiable {
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

extension Network: Hashable, Codable {}

// MARK: - Faking

extension Network: Faking {
    init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        name = "HBO"
    }
}

// MARK: - empty

extension Network {
    static var empty = Genre(
        id: .init(value: Int.random(in: Int.min ... 0)),
        name: ""
    )
}

// MARK: - Test

extension Network {
    public static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        name: String = "HBO"
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

// MARK: - asNetwork

extension NetworkRemote {
    var asNetwork: Network {
        .init(
            id: .init(value: id),
            name: name
        )
    }
}
