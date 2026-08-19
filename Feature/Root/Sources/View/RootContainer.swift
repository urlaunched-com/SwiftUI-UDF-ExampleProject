//
//  RootContainer.swift
//  Flick
//
//  Created by Max Kuznetsov on 09.11.2022.
//

import Common
import SwiftUI
import UDF

public struct RootContainer<F: RootFeature, R: Routing>: Container where R.Route == RootRoute {
    public typealias ContainerComponent = RootComponent<R>

    public func scope(for state: F) -> Scope {
        state.rootForm
        state.tabBarForm
    }
    
    public init() {}

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            isNeedToPresentOnboarding: store.state.rootForm.isNeedToPresentOnboarding,
            selectedTab: store.$state.tabBarForm.selectedTab,
            homeTabPath: Binding(
                get: { store.state.tabBarForm.homeNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \F.TabBarForm.homeNavigationPath, value: $0)) }
            ),
            searchTabPath: Binding(
                get: { store.state.tabBarForm.searchNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \F.TabBarForm.searchNavigationPath, value: $0)) }
            ),
            randomizerTabPath: Binding(
                get: { store.state.tabBarForm.randomizerNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \F.TabBarForm.randomizerNavigationPath, value: $0)) }
            ),
            favoritesTabPath: Binding(
                get: { store.state.tabBarForm.favoritesNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \F.TabBarForm.favoritesNavigationPath, value: $0)) }
            ),
            profileTabPath: Binding(
                get: { store.state.tabBarForm.profileNavigationPath },
                set: { store.dispatch(Actions.UpdateFormField(keyPath: \F.TabBarForm.profileNavigationPath, value: $0)) }
            ),
            router: .init(routing: R())
        )
    }
}
