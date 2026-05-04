//
//  OnboardingContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 11.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct OnboardingContainer: Container {
    typealias ContainerComponent = OnboardingComponent

    func scope(for state: AppState) -> Scope {
        state.rootForm
    }

    func map(store _: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            skipAction: skipOnboarding
        )
    }
}

extension OnboardingContainer {
    func skipOnboarding() {
        store.dispatch(Actions.UpdateFormField(keyPath: \RootForm.isNeedToPresentOnboarding, value: false))
    }
}
