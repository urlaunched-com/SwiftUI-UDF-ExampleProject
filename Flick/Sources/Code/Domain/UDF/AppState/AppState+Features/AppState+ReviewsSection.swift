//
//  AppState+ReviewsSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import ReviewsSection
import Models
import NetworkConnectivity

extension AppState: ReviewsSectionFeature {
    typealias ReviewsSectionEnvironment = AppEnvironments
}
extension NetworkConnectivity.NetworkConnectivityForm: ReviewsSection.NetworkConnectivityForm {}
