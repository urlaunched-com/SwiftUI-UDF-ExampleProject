//
//  ItemDetailsRoute.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

public enum ItemDetailsRoute: Hashable {
    case cast(any Item)
    case reviews(any Item)
    case recommendations(any Item)
    case whereToWatch(any Item)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .cast(item):
            hasher.combine(item)
        case let .reviews(item):
            hasher.combine(item)
        case let .recommendations(item):
            hasher.combine(item)
        case let .whereToWatch(item):
            hasher.combine(item)
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.cast(lhsItem), .cast(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.reviews(lhsItem), .reviews(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.recommendations(lhsItem), .recommendations(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.whereToWatch(lhsItem), .whereToWatch(rhsItem)):
            areEqual(lhsItem, rhsItem)
        default:
            false
        }
    }
}
