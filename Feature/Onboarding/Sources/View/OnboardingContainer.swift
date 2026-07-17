//
//  OnboardingContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 11.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

public struct OnboardingContainer<F: OnboardingFeature>: Container {
    public typealias ContainerComponent = OnboardingComponent
    
    public init() {}

    public func scope(for state: F) -> Scope {
        .none
    }

    public func map(store _: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            skipAction: skipOnboarding
        )
    }
    
    func skipOnboarding() {
        store.dispatch(
            Actions.UpdateFormField(keyPath: \F.RootForm.isNeedToPresentOnboarding, value: false)
        )
    }
}
