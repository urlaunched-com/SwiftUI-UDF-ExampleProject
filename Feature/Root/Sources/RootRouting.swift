//
//  RootRouting.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF

/// The flows the app shell shows, resolved by the app.
public enum RootRoute: Hashable {
    case onboarding
    case signIn
    case home
    case search
    case randomizer
    case favorites
    case profile
}

// MARK: - Tab navigation paths

extension TabBarForm {
    var homeNavigationPath: NavigationPath {
        get { homeNavigationForm.path }
        set { homeNavigationForm.path = newValue }
    }

    var searchNavigationPath: NavigationPath {
        get { searchNavigationForm.path }
        set { searchNavigationForm.path = newValue }
    }

    var randomizerNavigationPath: NavigationPath {
        get { randomizerNavigationForm.path }
        set { randomizerNavigationForm.path = newValue }
    }

    var favoritesNavigationPath: NavigationPath {
        get { favoritesNavigationForm.path }
        set { favoritesNavigationForm.path = newValue }
    }

    var profileNavigationPath: NavigationPath {
        get { profileNavigationForm.path }
        set { profileNavigationForm.path = newValue }
    }
}
