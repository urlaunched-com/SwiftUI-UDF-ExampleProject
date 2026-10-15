//
//  AppEnvironments+Image.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Image
import API

extension AppEnvironments: ImageEnvironmentProviding {
    static var imageEnvironment: ImageEnvironment {
        ImageEnvironment(
            loadImageConfigs: {
                try await ImageConfigsAPIClient.loadConfigs().asImageConfigs
            }
        )
    }
}
