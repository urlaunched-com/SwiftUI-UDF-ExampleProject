//
//  TabBarForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import SwiftFoundation
import SwiftUI
import UDF

struct TabBarForm: UDF.Form {
    enum HomeTab {}
    enum SearchTab {}
    enum RandomizerTab {}
    enum FavoritesTab {}
    enum ProfileTab {}

    var selectedTab: TabBarItem = .home
    var isTabBarHidden: Bool = false

    var homeNavigationForm: NavigationTabForm<HomeTab> = .init()
    var searchNavigationForm: NavigationTabForm<SearchTab> = .init()
    var randomizerNavigationForm: NavigationTabForm<RandomizerTab> = .init()
    var favoritesNavigationForm: NavigationTabForm<FavoritesTab> = .init()
    var profileNavigationForm: NavigationTabForm<ProfileTab> = .init()

    private var selectedTabPath: NavigationPath {
        get {
            switch selectedTab {
            case .home: homeNavigationForm.path
            case .search: searchNavigationForm.path
            case .randomizer: randomizerNavigationForm.path
            case .favorites: favoritesNavigationForm.path
            case .profile: profileNavigationForm.path
            }
        }
        set {
            switch selectedTab {
            case .home: homeNavigationForm.path = newValue
            case .search: searchNavigationForm.path = newValue
            case .randomizer: randomizerNavigationForm.path = newValue
            case .favorites: favoritesNavigationForm.path = newValue
            case .profile: profileNavigationForm.path = newValue
            }
        }
    }

    mutating func reduce(_ action: some Action) {
        switch action {
        case is Actions.NavigateBack:
            selectedTabPath.removeLastSafely()
            updateTabBarHidden(selectedTabPath)

        case is Actions.NavigationBackToRoot:
            selectedTabPath = .init()
            updateTabBarHidden(selectedTabPath)

        case let action as Actions.Navigate:
            for item in action.to {
                selectedTabPath.append(item)
            }
            updateTabBarHidden(selectedTabPath)

        case let action as Actions.NavigateResetStack:
            selectedTabPath = .init()
            for item in action.to {
                selectedTabPath.append(item)
            }
            updateTabBarHidden(selectedTabPath)

        case let action as Actions.UpdateFormField<NavigationTabForm<HomeTab>> where action.keyPath == \.path:
            guard let path = action.value as? NavigationPath else {
                break
            }

            updateTabBarHidden(path)

        case let action as Actions.UpdateFormField<NavigationTabForm<SearchTab>> where action.keyPath == \.path:
            guard let path = action.value as? NavigationPath else {
                break
            }

            updateTabBarHidden(path)

        case let action as Actions.UpdateFormField<NavigationTabForm<RandomizerTab>> where action.keyPath == \.path:
            guard let path = action.value as? NavigationPath else {
                break
            }

            updateTabBarHidden(path)

        case let action as Actions.UpdateFormField<NavigationTabForm<FavoritesTab>> where action.keyPath == \.path:
            guard let path = action.value as? NavigationPath else {
                break
            }

            updateTabBarHidden(path)

        case let action as Actions.UpdateFormField<NavigationTabForm<ProfileTab>> where action.keyPath == \.path:
            guard let path = action.value as? NavigationPath else {
                break
            }

            updateTabBarHidden(path)

        default:
            updateTabBarHidden()
        }
    }

    /// Hides tab bar if the user is navigating forward from the home screen.
    private mutating func updateTabBarHidden(_ path: NavigationPath? = nil) {
        if let path {
            isTabBarHidden = !path.isEmpty
        } else {
            isTabBarHidden = [
                homeNavigationForm.path.isEmpty,
                searchNavigationForm.path.isEmpty,
                randomizerNavigationForm.path.isEmpty,
                favoritesNavigationForm.path.isEmpty,
                profileNavigationForm.path.isEmpty,
            ]
            .filter { $0 == false }.isNotEmpty
        }
    }
}

/// Provides navigation path for the given tab.
/// Handles typed navigation methods.
struct NavigationTabForm<Routing>: UDF.Form {
    var path = NavigationPath()

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.NavigateTyped<Routing>:
            for item in action.to {
                path.append(item)
            }

        case let action as Actions.NavigateResetStackTyped<Routing>:
            path = .init()
            for item in action.to {
                path.append(item)
            }

        case is Actions.NavigateBackTyped<Routing>:
            path.removeLastSafely()

        case is Actions.NavigationBackToRootTyped<Routing>:
            path.removeLast(path.count)

        default:
            break
        }
    }
}

extension NavigationPath {
    mutating func removeLastSafely() {
        if !isEmpty {
            removeLast()
        }
    }
}
