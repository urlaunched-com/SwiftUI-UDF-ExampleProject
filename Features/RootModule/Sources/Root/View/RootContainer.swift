//
//  RootContainer.swift
//  Flick
//
//  Created by Max Kuznetsov on 09.11.2022.
//

import Common
import SwiftUI
import UDF

struct RootContainer<F: RootFeature>: Container {
    typealias ContainerComponent = RootComponent<RootScreenRouting<F>>

    func scope(for state: F) -> Scope {
        state.rootFeatureState.rootForm
        state.rootFeatureState.tabBarForm
    }
    
    init() {}

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            isNeedToPresentOnboarding: store.state.rootFeatureState.rootForm.isNeedToPresentOnboarding,
            selectedTab: store.$state.rootFeatureState.tabBarForm.selectedTab,
            homeTabPath: Binding(
                get: { store.state.rootFeatureState.tabBarForm.homeNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \TabBarForm.homeNavigationPath, value: $0)) }
            ),
            searchTabPath: Binding(
                get: { store.state.rootFeatureState.tabBarForm.searchNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \TabBarForm.searchNavigationPath, value: $0)) }
            ),
            randomizerTabPath: Binding(
                get: { store.state.rootFeatureState.tabBarForm.randomizerNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \TabBarForm.randomizerNavigationPath, value: $0)) }
            ),
            favoritesTabPath: Binding(
                get: { store.state.rootFeatureState.tabBarForm.favoritesNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \TabBarForm.favoritesNavigationPath, value: $0)) }
            ),
            profileTabPath: Binding(
                get: { store.state.rootFeatureState.tabBarForm.profileNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \TabBarForm.profileNavigationPath, value: $0)) }
            ),
            router: .init(routing: RootScreenRouting<F>())
        )
    }
}
