//
//  Review.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import SwiftFoundation

struct Review: Identifiable {
    struct ID: Hashable, Codable {
        var value: String
    }

    var id: ID
    var author: String
    var authorDetails: Author
    var content: String

    init(
        id: ID,
        author: String,
        authorDetails: Author,
        content: String
    ) {
        self.id = id
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
    }
}

// MARK: - Hashable, Codable

extension Review: Hashable, Codable {}

// MARK: - Faking

extension Review: Faking {
    init() {
        id = .init(value: "\(Int.random(in: Int.min ... 0))")
        author = "Cat Ellington"
        authorDetails = Author.fakeItem()
        content = "(As I'm writing this review, Darth Vader's theme music begins to build in my mind...)\r\n\r\nWell, it actually has a title, what the Darth Vader theme. And that title is \"The Imperial March\", composed by the great John Williams, whom, as many of you may already know, also composed the theme music for \"Jaws\" - that legendary score simply titled, \"Main Title (Theme From Jaws)\".\r\n\r\nNow, with that lil' bit of trivia aside, let us procede with the fabled film currently under review: Star Wars.😊"
    }
}

// MARK: - empty

extension Review {
    static var empty = Review(
        id: .init(value: "\(Int.random(in: Int.min ... 0))"),
        author: "",
        authorDetails: Author.empty,
        content: ""
    )
}

// MARK: - Test

extension Review {
    public static func testItem(
        id: ID = .init(value: "\(Int.random(in: Int.min ... 0))"),
        author: String = "Cat Ellington",
        authorDetails: Author = Author.testItem(),
        content: String = "As I'm writing this review, Darth Vader's theme music begins to build..."
    ) -> Self {
        .init(
            id: id,
            author: author,
            authorDetails: authorDetails,
            content: content
        )
    }

    public static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: "\($0)")) }
    }

    public static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: "\($0)") }
    }
}

// MARK: - asReview

extension ReviewRemote {
    var asReview: Review {
        .init(
            id: .init(value: id),
            author: author,
            authorDetails: authorDetails.asAuthor,
            content: content
        )
    }
}
