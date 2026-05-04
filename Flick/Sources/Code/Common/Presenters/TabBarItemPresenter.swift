//
//  TabBarItemPresenter.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import SwiftUI

struct TabBarItemPresenter {
    private let tabBarItem: TabBarItem
    private let isSelected: Bool

    init(item: TabBarItem, isSelected: Bool) {
        tabBarItem = item
        self.isSelected = isSelected
    }

    var image: Image {
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
        isSelected ? .flMainPink : .flPink60
    }
}
