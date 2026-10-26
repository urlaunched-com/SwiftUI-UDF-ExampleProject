//
//  SignInContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Common
import SwiftUI_Kit

struct SignInContainer<F: SignInFeature>: Container {
    typealias ContainerComponent = SignInComponent<F.SignInRouting>
    @Environment(\.dismiss) var dismiss

    func scope(for state: F) -> Scope {
        state.signInFeatureState.signInForm
        state.signInFeatureState.signInFlow
    }
    
    init() {}

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        return .init(
            username: store.$state.signInFeatureState.signInForm.username,
            password: store.$state.signInFeatureState.signInForm.password,
            signInAction: { dismiss() },
            isLoaderPresented: .init { store.state.signInFeatureState.signInFlow != .none },
            dialogStatus: store.$state.signInFeatureState.signInForm.dialog
        )
    }
}
