//
//  AppState+Root.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

import Root
import SwiftUI
import TabBar

extension AppState: RootFeature {
    typealias TabBarForm = TabBar.TabBarForm
}

extension TabBar.TabBarForm: @retroactive RootType.TabBarForm {
    public var homeNavigationPath: NavigationPath {
        get { homeNavigationForm.path }
        set { homeNavigationForm.path = newValue }
    }

    public var searchNavigationPath: NavigationPath {
        get { searchNavigationForm.path }
        set { searchNavigationForm.path = newValue }
    }

    public var randomizerNavigationPath: NavigationPath {
        get { randomizerNavigationForm.path }
        set { randomizerNavigationForm.path = newValue }
    }

    public var favoritesNavigationPath: NavigationPath {
        get { favoritesNavigationForm.path }
        set { favoritesNavigationForm.path = newValue }
    }

    public var profileNavigationPath: NavigationPath {
        get { profileNavigationForm.path }
        set { profileNavigationForm.path = newValue }
    }
}
