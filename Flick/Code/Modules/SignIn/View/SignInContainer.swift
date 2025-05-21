//
//  SignInContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct SignInContainer: Container {
    typealias ContainerComponent = SignInComponent
    @Environment(\.dismiss) var dismiss

    func scope(for state: AppState) -> Scope {
        state.signInForm
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            username: store.$state.signInForm.username,
            password: store.$state.signInForm.password,
            signInAction: { dismiss() },
            isLoaderPresented: .init { store.state.signInFlow != .none },
            alertStatus: store.$state.signInForm.alert
        )
    }
}
