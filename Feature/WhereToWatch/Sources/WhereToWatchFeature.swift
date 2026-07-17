//
//  WhereToWatchFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public protocol WhereToWatchFeature: AppReducer {
    associatedtype HomeFlow: WhereToWatch.HomeFlow
    
    var homeFlow: HomeFlow { get }
}

public enum WhereToWatch {
    public protocol HomeFlow: Form { }
}
