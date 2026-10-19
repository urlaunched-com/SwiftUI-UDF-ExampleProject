//
//  SettingsContainer.swift
//  Flick
//
//  Created by Arthur Zavolovych on 15.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import UIKit
import Common

struct SettingsContainer<F: SettingsFeature>: Container {
    typealias ContainerComponent = SettingsComponent

    init() {}

    func scope(for state: F) -> Scope {
        state.homeForm
    }

    func map(store _: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            rateThisAppAction: UIApplication.shared.requestReview
        )
    }
    
    func onContainerDidLoad(store: EnvironmentStore<F>) {
        print("onContainerDidLoad(store: EnvironmentStore<F>)")
    }
}
