//
//  Cast.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation

public struct Cast: Identifiable {
    public struct ID: Hashable, Codable {
        public var value: Int
        
        public init(value: Int) {
            self.value = value
        }
    }

    public var id: ID
    public var name: String
    public var character: String
    public var profilePath: String?

    public init(
        id: ID,
        name: String,
        character: String,
        profilePath: String?
    ) {
        self.id = id
        self.name = name
        self.character = character
        self.profilePath = profilePath
    }
}

// MARK: - Hashable, Codable

extension Cast: Hashable, Codable {}

// MARK: - Faking

extension Cast: Faking {
    public init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        name = "Emilia Clarke"
        character = "Daenerys Targaryen"
        profilePath = "/r6i4C3kYrBRzUzZ8JKAHYQ0T0dD.jpg"
    }
}

// MARK: - empty

public extension Cast {
    static var empty = Cast(
        id: .init(value: Int.random(in: Int.min ... 0)),
        name: "",
        character: "",
        profilePath: nil
    )
}

// MARK: - Test

public extension Cast {
    static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        name: String = "Emilia Clarke",
        character: String = "Daenerys Targaryen",
        profilePath: String? = "/r6i4C3kYrBRzUzZ8JKAHYQ0T0dD.jpg"
    ) -> Self {
        .init(
            id: id,
            name: name,
            character: character,
            profilePath: profilePath
        )
    }

    static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: $0)) }
    }

    static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: $0) }
    }
}

// MARK: - asCast

public extension CastRemote {
    var asCast: Cast {
        .init(
            id: .init(value: id),
            name: name,
            character: character,
            profilePath: profilePath
        )
    }
}
