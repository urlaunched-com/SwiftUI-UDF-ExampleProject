//
//  SetNavigationTab.swift
//  Flick
//
//  Created by Maksym Horobets on 22.10.2026.
//  © 2026 You are launched
//

import UDF
import Common

public extension Actions {
    /// Selects a tab and replaces its navigation stack with the given links, in one step.
    struct SetNavigationTab: Action {
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.tab == rhs.tab && lhs.path.map { AnyHashable($0) } == rhs.path.map { AnyHashable($0) }
        }

        public let tab: TabBarItem
        public let path: [any Hashable & Sendable]

        public init(tab: TabBarItem, path: [any Hashable & Sendable]) {
            self.tab = tab
            self.path = path
        }
    }
}
