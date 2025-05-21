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

struct Cast: Identifiable {
    struct ID: Hashable, Codable {
        var value: Int
    }

    var id: ID
    var name: String
    var character: String
    var profilePath: String?

    init(
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
    init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        name = "Emilia Clarke"
        character = "Daenerys Targaryen"
        profilePath = "/r6i4C3kYrBRzUzZ8JKAHYQ0T0dD.jpg"
    }
}

// MARK: - empty

extension Cast {
    static var empty = Cast(
        id: .init(value: Int.random(in: Int.min ... 0)),
        name: "",
        character: "",
        profilePath: nil
    )
}

// MARK: - Test

extension Cast {
    public static func testItem(
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

    public static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: $0)) }
    }

    public static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: $0) }
    }
}

// MARK: - asCast

extension CastRemote {
    var asCast: Cast {
        .init(
            id: .init(value: id),
            name: name,
            character: character,
            profilePath: profilePath
        )
    }
}
