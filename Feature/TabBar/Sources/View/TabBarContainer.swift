//
//  TabBarContainer.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

struct TabBarContainer<F: TabBarFeature>: Container {
    typealias ContainerComponent = TabBarComponent

    init() {}

    func scope(for state: F) -> Scope {
        state.tabBarFeatureState.tabBarForm
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            selectedTab: store.$state.tabBarFeatureState.tabBarForm.selectedTab,
            isHidden: store.$state.tabBarFeatureState.tabBarForm.isTabBarHidden
        )
    }
}
