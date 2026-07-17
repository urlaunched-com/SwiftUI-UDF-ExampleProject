//
//  AppState+WhereToWatch.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import WhereToWatch

extension AppState: WhereToWatchFeature {
    typealias HomeFlow = Flick.HomeFlow
}

extension HomeFlow: WhereToWatch.HomeFlow {}


