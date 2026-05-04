//
//  TabBarContainer.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct TabBarContainer: Container {
    typealias ContainerComponent = TabBarComponent

    func scope(for state: AppState) -> Scope {
        state.tabBarForm
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            selectedTab: store.$state.tabBarForm.selectedTab,
            isHidden: store.$state.tabBarForm.isTabBarHidden
        )
    }
}
