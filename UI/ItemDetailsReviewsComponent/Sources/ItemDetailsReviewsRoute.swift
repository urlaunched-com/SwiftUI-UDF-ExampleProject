//
//  ItemDetailsReviewsRoute.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

public enum ItemDetailsReviewsRoute: Hashable {
    case reviewDetails(Review.ID)
    case reviews(any Item)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .reviewDetails(id):
            hasher.combine(id)
        case let .reviews(item):
            hasher.combine(item)
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.reviewDetails(lhsId), .reviewDetails(rhsId)):
            areEqual(lhsId, rhsId)
        case let (.reviews(lhsItem), .reviews(rhsItem)):
            areEqual(lhsItem, rhsItem)
        default:
            false
        }
    }
}
