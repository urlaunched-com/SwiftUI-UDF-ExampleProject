//
//  RootFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import SwiftUI
import UDF

public protocol RootFeature: AppReducer {
    associatedtype TabBarForm: RootType.TabBarForm

    var rootForm: RootForm { get }
    var tabBarForm: TabBarForm { get }
}

public enum RootType {
    public protocol TabBarForm: UDF.Form {
        var selectedTab: TabBarItem { get set }
        var homeNavigationPath: NavigationPath { get set }
        var searchNavigationPath: NavigationPath { get set }
        var randomizerNavigationPath: NavigationPath { get set }
        var favoritesNavigationPath: NavigationPath { get set }
        var profileNavigationPath: NavigationPath { get set }
    }
}
