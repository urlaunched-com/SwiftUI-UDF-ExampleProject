//
//  SettingsContainer.swift
//  Flick
//
//  Created by Arthur Zavolovych on 15.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import UIKit

public struct SettingsContainer<F: SettingsFeature>: Container {
    public typealias ContainerComponent = SettingsComponent

    public init() {}

    public func scope(for state: F) -> Scope {
        state.homeForm
    }

    public func map(store _: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            rateThisAppAction: UIApplication.shared.requestReview
        )
    }
    
    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        print("onContainerDidLoad(store: EnvironmentStore<F>)")
    }
}
