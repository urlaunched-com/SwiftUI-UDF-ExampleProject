//
//  RootComponent.swift
//  Flick
//
//  Created by Max Kuznetsov on 09.11.2022.
//

import SwiftUI
import UDF

struct RootComponent: Component {
    struct Props {
        var isNeedToPresentOnboarding: Bool
        var selectedTab: Binding<TabBarItem>
        var homeTabPath: Binding<NavigationPath>
        var searchTabPath: Binding<NavigationPath>
        var randomizerTabPath: Binding<NavigationPath>
        var favoritesTabPath: Binding<NavigationPath>
        var profileTabPath: Binding<NavigationPath>
        var router: Router<RootRouting> = .init()
    }

    var props: Props

    @State private var isSignInPresented = false
    @State private var selectedTab: TabBarItem = .home

    var body: some View {
        if props.isNeedToPresentOnboarding {
            props.router.view(for: .onboarding)
        } else {
            TabView(selection: props.selectedTab) {
                NavigationStack(path: props.homeTabPath) {
                    props.router.view(for: .home)
                        .homeNavigationsDestinations()
                }
                .tag(TabBarItem.home)
                .environment(\.globalRouter, GlobalRouter(path: props.homeTabPath))

                NavigationStack(path: props.searchTabPath) {
                    props.router.view(for: .search)
                }
                .tag(TabBarItem.search)
                .environment(\.globalRouter, GlobalRouter(path: props.searchTabPath))

                NavigationStack(path: props.randomizerTabPath) {
                    props.router.view(for: .randomizer)
                }
                .tag(TabBarItem.randomizer)
                .environment(\.globalRouter, GlobalRouter(path: props.randomizerTabPath))

                NavigationStack(path: props.favoritesTabPath) {
                    props.router.view(for: .favorites)
                }
                .tag(TabBarItem.favorites)
                .environment(\.globalRouter, GlobalRouter(path: props.favoritesTabPath))

                NavigationStack(path: props.profileTabPath) {
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

// MARK: - Navigation Destinations

private extension View {
    func homeNavigationsDestinations() -> some View {
        navigationDestination(for: HomeRouting.self)
            .navigationDestination(for: MainHomeSectionRouting.self)
            .navigationDestination(for: SectionDetailsRouting.self)
            .navigationDestination(for: ItemDetailsRouting.self)
            .navigationDestination(for: ItemDetailsCastRouting.self)
            .navigationDestination(for: ItemDetailsReviewsRouting.self)
            .navigationDestination(for: ItemDetailsRecommendationsRouting.self)
            .navigationDestination(for: ReviewsRouting.self)
    }
}
