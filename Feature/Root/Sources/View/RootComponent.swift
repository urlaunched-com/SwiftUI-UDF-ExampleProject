//
//  RootComponent.swift
//  Flick
//
//  Created by Max Kuznetsov on 09.11.2022.
//

import Common
import SwiftUI
import UDF

public struct RootComponent<R: Routing>: Component where R.Route == RootRoute {
    public struct Props {
        var isNeedToPresentOnboarding: Bool
        var selectedTab: Binding<TabBarItem>
        var homeTabPath: Binding<NavigationPath>
        var searchTabPath: Binding<NavigationPath>
        var randomizerTabPath: Binding<NavigationPath>
        var favoritesTabPath: Binding<NavigationPath>
        var profileTabPath: Binding<NavigationPath>
        var router: Router<R>

        public init(
            isNeedToPresentOnboarding: Bool,
            selectedTab: Binding<TabBarItem>,
            homeTabPath: Binding<NavigationPath>,
            searchTabPath: Binding<NavigationPath>,
            randomizerTabPath: Binding<NavigationPath>,
            favoritesTabPath: Binding<NavigationPath>,
            profileTabPath: Binding<NavigationPath>,
            router: Router<R>,
        ) {
            self.isNeedToPresentOnboarding = isNeedToPresentOnboarding
            self.selectedTab = selectedTab
            self.homeTabPath = homeTabPath
            self.searchTabPath = searchTabPath
            self.randomizerTabPath = randomizerTabPath
            self.favoritesTabPath = favoritesTabPath
            self.profileTabPath = profileTabPath
            self.router = router
        }
    }

    public var props: Props

    @State private var isSignInPresented = false

    public init(props: Props) {
        self.props = props 
    }

    public var body: some View {
        if props.isNeedToPresentOnboarding {
            props.router.view(for: .onboarding)
        } else {
            TabView(selection: props.selectedTab) {
                NavigationStackBound(path: props.homeTabPath) {
                    props.router.view(for: .home)
                }
                .tag(TabBarItem.home)
                .environment(\.globalRouter, GlobalRouter(path: props.homeTabPath))

                NavigationStackBound(path: props.searchTabPath) {
                    props.router.view(for: .search)
                }
                .tag(TabBarItem.search)
                .environment(\.globalRouter, GlobalRouter(path: props.searchTabPath))

                NavigationStackBound(path: props.randomizerTabPath) {
                    props.router.view(for: .randomizer)
                }
                .tag(TabBarItem.randomizer)
                .environment(\.globalRouter, GlobalRouter(path: props.randomizerTabPath))

                NavigationStackBound(path: props.favoritesTabPath) {
                    props.router.view(for: .favorites)
                }
                .tag(TabBarItem.favorites)
                .environment(\.globalRouter, GlobalRouter(path: props.favoritesTabPath))

                NavigationStackBound(path: props.profileTabPath) {
                    props.router.view(for: .profile)
                }
                .tag(TabBarItem.profile)
                .environment(\.globalRouter, GlobalRouter(path: props.profileTabPath))
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbarBackground(.hidden, for: .tabBar)
            .safeAreaInset(edge: .bottom) {
                props.router.view(for: .tabBar)
            }
            .background(Color.flMain.ignoresSafeArea())
            .fullScreenCover(isPresented: $isSignInPresented) {
                props.router.view(for: .signIn)
            }
        }
    }
}
