//
//  Search+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//

import API
import Models
import Search

public extension SearchEnvironment {
    static var live: Self {
        .init(
            loadItems: { query, page in
                try await SearchAPIClient.loadSearchItems(query: query, page: page)
                    .map(\.asSearchItem)
            }
        )
    }
}
