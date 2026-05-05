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

public struct Network: Identifiable {
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

extension Network: Hashable, Codable {}

// MARK: - Faking

extension Network: Faking {
    public init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        name = "HBO"
    }
}

// MARK: - empty

public extension Network {
    static var empty = Genre(
        id: .init(value: Int.random(in: Int.min ... 0)),
        name: ""
    )
}

// MARK: - Test

public extension Network {
    static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        name: String = "HBO"
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

// MARK: - asNetwork

public extension NetworkRemote {
    var asNetwork: Network {
        .init(
            id: .init(value: id),
            name: name
        )
    }
}
