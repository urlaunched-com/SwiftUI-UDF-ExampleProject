//
//  RootContainer.swift
//  Flick
//
//  Created by Max Kuznetsov on 09.11.2022.
//

import SwiftUI
import UDF

struct RootContainer: Container {
    typealias ContainerComponent = RootComponent

    func scope(for state: AppState) -> Scope {
        state.rootForm
        state.tabBarForm
    }

    func map(store: EnvironmentStore<AppState>) -> RootComponent.Props {
        .init(
            isNeedToPresentOnboarding: store.state.rootForm.isNeedToPresentOnboarding,
            selectedTab: store.$state.tabBarForm.selectedTab,
            homeTabPath: store.$state.tabBarForm.homeNavigationForm.path,
            searchTabPath: store.$state.tabBarForm.searchNavigationForm.path,
            randomizerTabPath: store.$state.tabBarForm.randomizerNavigationForm.path,
            favoritesTabPath: store.$state.tabBarForm.favoritesNavigationForm.path,
            profileTabPath: store.$state.tabBarForm.profileNavigationForm.path
        )
    }
}
