//
//  Search+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
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
