//
//  CastFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import Common

public protocol CastFeature: AppReducer {
    associatedtype CastAllCast: Storage<Models.Cast>
    associatedtype CastFeatureNavigation: Common.FeatureNavigation where CastFeatureNavigation.Routing.Route == CastRoute

    var castForm: CastForm { get }
    var allCast: CastAllCast { get }
    
    var castNavigation: CastFeatureNavigation { get }
}
