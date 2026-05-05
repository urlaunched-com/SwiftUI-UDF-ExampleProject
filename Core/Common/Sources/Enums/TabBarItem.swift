//
//  TabBarItem.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import Foundation

public enum TabBarItem: String, Hashable, CaseIterable {
    case home, search, randomizer, favorites, profile

    public var id: Self { self }
}
