//
//  SignInRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import SignIn

struct SignInRouting: Routing {
    @ViewBuilder func view(for route: SignInRoute) -> some View {
        switch route {
        case .resetPassword:
            Text("Reset Password")
        case .signUp:
            Text("Sign Up")
        }
    }
}
