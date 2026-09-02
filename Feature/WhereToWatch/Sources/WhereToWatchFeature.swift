//
//  WhereToWatchFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common

public protocol WhereToWatchFeature: AppReducer {
    associatedtype HomeFlow: WhereToWatch.HomeFlow
    associatedtype WhereToWatchNavigation: Common.FeatureNavigation where WhereToWatchNavigation.Routing.Route == WhereToWatchRouter
    
    var homeFlow: HomeFlow { get }
    var whereToWatchNavigation: WhereToWatchNavigation { get }
}

public enum WhereToWatch {
    public protocol HomeFlow: Form { }
}
