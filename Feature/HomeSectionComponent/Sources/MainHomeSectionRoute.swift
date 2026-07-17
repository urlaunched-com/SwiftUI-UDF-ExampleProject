//
//  HomeSectionRoute.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

public enum HomeSectionRoute: Hashable {
    case itemDetails(any Item)
    case sectionDetails(any Models.Section)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .itemDetails(item):
            hasher.combine(item)
        case let .sectionDetails(section):
            hasher.combine(section)
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.itemDetails(lhsItem), .itemDetails(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.sectionDetails(lhsSection), .sectionDetails(rhsSection)):
            areEqual(lhsSection, rhsSection)
        default:
            false
        }
    }
}
