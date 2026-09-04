//
//  SignInFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common

public protocol SignInFeature: AppReducer {
    associatedtype SignInNavigation: Common.FeatureNavigation where SignInNavigation.Routing.Route == SignInRoute

    var signInForm: SignInForm { get }
    var signInFlow: SignInFlow { get }
    var signInNavigation: SignInNavigation { get }
}
