//
//  AppState+SignInFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SignIn
import Common

extension AppState: SignInFeature {
    struct SignInFeatureNavigation: Common.FeatureNavigation {
        typealias Routing = SignInRouting
        typealias EntryPoint = SignInEntryPoint<AppState>

        let routing: SignInRouting
    }

    var signInNavigation: SignInFeatureNavigation {
        .init(routing: AppRouter.shared.signInRouting)
    }
}
