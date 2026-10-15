//
//  HomeRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

/// Routes the Home flow asks its host to resolve. Everything else is resolved inside the flow.
///
/// Hashable is written by hand: `@AutoHashable` generates internal members, which a public enum's
/// conformance can't use.
public enum HomeRoute: Hashable {
    /// The details of a movie or a show, owned by another flow.
    case itemDetails(any Item)
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster, isLoaderPresented: Bool = true)

    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .itemDetails(item):
            hasher.combine(item)
        case let .imageContainer(path, size, type, isLoaderPresented):
            hasher.combine(path)
            hasher.combine(size.width)
            hasher.combine(size.height)
            hasher.combine(type)
            hasher.combine(isLoaderPresented)
        }
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.itemDetails(lhsItem), .itemDetails(rhsItem)):
            areEqual(lhsItem, rhsItem)
        case let (.imageContainer(lhsPath, lhsSize, lhsType, lhsLoader), .imageContainer(rhsPath, rhsSize, rhsType, rhsLoader)):
            lhsPath == rhsPath && lhsSize == rhsSize && lhsType == rhsType && lhsLoader == rhsLoader
        default:
            false
        }
    }
}

/// Registers every screen of the flow that can be pushed onto the hosting navigation stack.
struct HomeDestinations<AppState: HomeFeature>: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: MainHomeSectionRouting<AppState>.self)
            .navigationDestination(for: HomeSectionRouting<AppState>.self)
            .navigationDestination(for: SectionDetailsRouting<AppState>.self)
    }
}
