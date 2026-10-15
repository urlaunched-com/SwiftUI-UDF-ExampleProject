//
//  Image+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
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
