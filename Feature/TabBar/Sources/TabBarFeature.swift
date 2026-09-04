//
//  TabBarFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UDF

public protocol TabBarFeature: AppReducer {
    var tabBarForm: TabBarForm { get }
}
