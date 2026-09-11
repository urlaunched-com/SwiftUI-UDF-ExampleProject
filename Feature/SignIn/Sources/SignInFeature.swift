//
//  SignInFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Common
import SwiftUI

public protocol SignInFeature: AppReducer {
    associatedtype SignInRouting: Routing<SignInRoute>

    var signInFeatureState: SignInFeatureState<Self, SignInRouting> { get }
}

public struct SignInFeatureState<AppState: SignInFeature, FeatureRouting: Routing<SignInRoute>>: FeatureState {
    var signInForm = SignInForm()
    var signInFlow = SignInFlow()
    
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        SignInContainer<AppState>()
    }
}
