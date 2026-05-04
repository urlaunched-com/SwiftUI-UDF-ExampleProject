//
//  SignInRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 18.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct SignInRouting: Routing {
    enum Route {
        case resetPassword
        case signUp
    }

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .resetPassword: Text("Reset password")
        case .signUp: Text("Sign Up")
        }
    }
}
