//
//  Author.swift
//  Flick
//
//  Created by Alexander Sharko on 07.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation

public struct Author {
    public var name: String
    public var username: String
    public var avatarPath: String?
    public var rating: Int?

    public init(
        name: String,
        username: String,
        avatarPath: String?,
        rating: Int?
    ) {
        self.name = name
        self.username = username
        self.avatarPath = avatarPath
        self.rating = rating
    }
}

// MARK: - Hashable, Codable

extension Author: Hashable, Codable {}

// MARK: - Faking

extension Author: Faking {
    public init() {
        name = "Cat Ellington"
        username = "CatEllington"
        avatarPath = "/uCmwgSbJAcHqNwSvQvTv2dB95tx.jpg"
        rating = 10
    }
}

// MARK: - empty

public extension Author {
    static var empty = Author(
        name: "",
        username: "",
        avatarPath: nil,
        rating: nil
    )
}

// MARK: - Test

public extension Author {
    static func testItem(
        name: String = "",
        username: String = "John Chard",
        avatarPath: String? = "/utEXl2EDiXBK6f41wCLsvprvMg4.jpg",
        rating: Int? = 10
    ) -> Self {
        .init(
            name: name,
            username: username,
            avatarPath: avatarPath,
            rating: rating
        )
    }
}

// MARK: - asAuthor

public extension AuthorRemote {
    var asAuthor: Author {
        .init(
            name: name,
            username: username,
            avatarPath: avatarPath,
            rating: rating
        )
    }
}
