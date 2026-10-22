//
//  Image+Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Image
import API

public extension ImageEnvironment {
    static var environment: Self {
        ImageEnvironment(
            loadImageConfigs: {
                try await ImageConfigsAPIClient.loadConfigs().asImageConfigs
            }
        )
    }
}
