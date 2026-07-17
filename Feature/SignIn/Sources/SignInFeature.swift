//
//  SignInFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public protocol SignInFeature: AppReducer {
    var signInForm: SignInForm { get }
    var signInFlow: SignInFlow { get }
}
