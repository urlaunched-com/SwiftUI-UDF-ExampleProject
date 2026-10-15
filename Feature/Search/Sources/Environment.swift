//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models

public protocol SearchEnvironmentProviding {
    static var searchEnvironment: SearchEnvironment { get }
}

public struct SearchEnvironment: Sendable {
    var loadItems: @Sendable (_ query: String, _ page: Int) async throws -> [SearchItem]

    public init(loadItems: @Sendable @escaping (_ query: String, _ page: Int) async throws -> [SearchItem]) {
        self.loadItems = loadItems
    }
}
