//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models

public protocol ReviewDetailsEnvironmentProviding {
    static var reviewDetailsEnvironment: Environment { get }
}

public struct Environment: Sendable {
    var loadShowReview: @Sendable (_ reviewID: Review.ID) async throws -> Review
    
    public init(loadShowReview: @Sendable @escaping (_: Review.ID) async throws -> Review) {
        self.loadShowReview = loadShowReview
    }
}
