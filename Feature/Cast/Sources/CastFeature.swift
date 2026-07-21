//
//  CastFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public protocol CastFeature: AppReducer {
    associatedtype AllCast: Cast.AllCast

    var castForm: CastForm { get }
    var allCast: AllCast { get }
}

public enum Cast {
    public protocol AllCast: Reducible {
        func castBy(id: Models.Cast.ID) -> Models.Cast
    }
}
