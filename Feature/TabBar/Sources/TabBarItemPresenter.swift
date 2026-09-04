//
//  TabBarItemPresenter.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import Common

struct TabBarItemPresenter {
    let tabBarItem: TabBarItem
    let isSelected: Bool

    var icon: Image {
        switch tabBarItem {
        case .home:
            isSelected ? .videoPlayFill : .videoPlay
        case .search:
            isSelected ? .searchFill : .search
        case .randomizer:
            .flick
        case .favorites:
            isSelected ? .heartFill : .heart
        case .profile:
            isSelected ? .userSquareFill : .userSquare
        }
    }

    var foregroundColor: Color {
        isSelected ? .flMainPink : .flGray
    }
}
