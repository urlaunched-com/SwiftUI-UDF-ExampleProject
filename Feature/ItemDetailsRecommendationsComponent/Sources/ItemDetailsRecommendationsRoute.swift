//
//  ItemDetailsRecommendationsRoute.swift
//  Flick
//
//  Created by Alexander Sharko on 05.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

public enum ItemDetailsRecommendationsRoute: Hashable {
    case itemDetails(any Item)
    case recommendations(any Item)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .itemDetails(item):
            hasher.combine(item)
        case let .recommendations(item):
            hasher.combine(item)
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.itemDetails(lhsItem), .itemDetails(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.recommendations(lhsItem), .recommendations(rhsItem)):
            areEqual(lhsItem, rhsItem)
        default:
            false
        }
    }
}
