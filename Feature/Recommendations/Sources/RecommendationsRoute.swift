//
//  RecommendationsRoute.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UIKit
import Models
import Common

public enum RecommendationsRoute: Hashable {
    case imageContainer(path: String?, size: CGSize)
    case itemDetails(any Item)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .itemDetails(item):
            hasher.combine(item)
        case .imageContainer(path: let path, size: let size):
            hasher.combine(path)
        }
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.itemDetails(lhsItem), .itemDetails(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.imageContainer(path: lhsPath, size: lhsSize), .imageContainer(path: rhsPath, size: rhsSize)):
            lhsPath == rhsPath && lhsSize == rhsSize
        default:
            false
        }
    }
}
