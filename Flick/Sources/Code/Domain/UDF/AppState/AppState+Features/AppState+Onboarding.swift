//
//  AppState+Onboarding.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Onboarding
import Root

extension AppState: OnboardingFeature {
    typealias RootForm = Root.RootForm
}

extension Root.RootForm: Onboarding.RootForm {}
