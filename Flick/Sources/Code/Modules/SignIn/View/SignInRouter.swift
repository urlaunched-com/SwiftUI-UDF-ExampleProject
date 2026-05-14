//
//  SignInRouter.swift
//  Flick
//
//  Created by Bogdan Petkanych on 14.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SignInComponent
import SwiftUI

struct SignInRouter: Routing {
    typealias Route = SignInRoute

    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .resetPassword:
            Text("Reset password")
        case .signUp:
            Text("Sign Up")
        }
    }
}
