//
//  SettingsContainer.swift
//  Flick
//
//  Created by Arthur Zavolovych on 15.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import UIKit
import SettingsComponent

struct SettingsContainer: Container {
    typealias ContainerComponent = SettingsComponent

    func scope(for state: AppState) -> Scope {
        state.homeForm
    }

    func map(store _: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            rateThisAppAction: UIApplication.shared.requestReview
        )
    }
}
