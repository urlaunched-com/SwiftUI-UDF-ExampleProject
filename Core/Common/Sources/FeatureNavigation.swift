//
//  FeatureNavigation.swift
//  Flick
//
//  Created by Bogdan Petkanych on 01.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public protocol FeatureNavigation {
    associatedtype Routing: UDF.Routing
    associatedtype EntryPoint: FeatureEntryPoint
    
    var routing: Routing { get }
}
