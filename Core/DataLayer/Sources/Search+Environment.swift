//
//  Search+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Search
import SearchModels
import API

public extension SearchEnvironment {
    static var environment: Self {
        SearchEnvironment(
            loadItems: { query, page in
                try await SearchAPIClient.loadSearchItems(query: query, page: page)
                    .map(\.asSearchItem)
            }
        )
    }
}
