//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

@preconcurrency import ImageModels

public protocol ImageEnvironmentProviding {
    static var imageEnvironment: ImageEnvironment { get }
}

public struct ImageEnvironment: Sendable {
    var loadImageConfigs: @Sendable () async throws -> ImageConfigs

    public init(loadImageConfigs: @Sendable @escaping () async throws -> ImageConfigs) {
        self.loadImageConfigs = loadImageConfigs
    }
}
