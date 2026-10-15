//
//  AppEnvironments+Search.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Search
import API

extension AppEnvironments: SearchEnvironmentProviding {
    static var searchEnvironment: SearchEnvironment {
        SearchEnvironment(
            loadItems: { query, page in
                try await SearchAPIClient.loadSearchItems(query: query, page: page)
                    .map(\.asSearchItem)
            }
        )
    }
}
