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
    associatedtype AllCast: Storage<Models.Cast>

    var castForm: CastForm { get }
    var allCast: AllCast { get }
}
