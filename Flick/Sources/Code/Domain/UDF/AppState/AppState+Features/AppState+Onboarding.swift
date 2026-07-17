//
//  AppState+Onboarding.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Onboarding

extension AppState: OnboardingFeature {
    typealias RootForm = Flick.RootForm
}

extension RootForm: Onboarding.RootForm {}
