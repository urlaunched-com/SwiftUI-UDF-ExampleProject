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

public struct SignInContainer<F: SignInFeature>: Container {
    public typealias ContainerComponent = SignInComponent<F.SignInNavigation.Routing>
    @Environment(\.dismiss) var dismiss

    public func scope(for state: F) -> Scope {
        state.signInForm
        state.signInFlow
    }
    
    public init() {}

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        return .init(
            username: store.$state.signInForm.username,
            password: store.$state.signInForm.password,
            signInAction: { dismiss() },
            isLoaderPresented: .init { store.state.signInFlow != .none },
            dialogStatus: store.$state.signInForm.dialog,
            router: .init(routing: store.state.signInNavigation.routing)
        )
    }
}
