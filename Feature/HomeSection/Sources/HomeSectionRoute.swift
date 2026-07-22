//
//  HomeSectionRoute.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

public enum HomeSectionRoute: Hashable {
    case itemDetails(any Item)
    case sectionDetails(any Models.Section)
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)

    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .itemDetails(item):
            hasher.combine(item)
        case let .sectionDetails(section):
            hasher.combine(section)
        case let .imageContainer(path, size, type):
            hasher.combine(path)
            hasher.combine(size.width)
            hasher.combine(size.height)
            hasher.combine(type)
        }
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.itemDetails(lhsItem), .itemDetails(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.sectionDetails(lhsSection), .sectionDetails(rhsSection)):
            areEqual(lhsSection, rhsSection)
        case let (.imageContainer(lhsPath, lhsSize, lhsType), .imageContainer(rhsPath, rhsSize, rhsType)):
            lhsPath == rhsPath && lhsSize == rhsSize && lhsType == rhsType
        default:
            false
        }
    }
}
