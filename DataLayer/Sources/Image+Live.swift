//
//  Image+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//

import API
import Models
import Image

public extension ImageConfigsEnvironment {
    static var live: Self {
        .init(
            loadImageConfigs: {
                try await ImageConfigsAPIClient.loadConfigs().asImageConfigs
            }
        )
    }
}
