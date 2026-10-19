//
//  ItemDetailsRouting.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//

import SwiftUI
import UDF
import Models
import Common

/// Routes the Item Details flow asks its host to resolve. Everything else is resolved inside the flow.
public enum ItemDetailsRoute: Hashable {
    /// The reviews section embedded in the details page, owned by another flow.
    case reviews(ReviewsTarget)
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}

/// Registers every screen of the flow that can be pushed onto the hosting navigation stack.
struct ItemDetailsDestinations<AppState: ItemDetailsFeature>: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: ItemDetailsScreenRouting<AppState>.self)
            .navigationDestination(for: CastSectionRouting<AppState>.self)
            .navigationDestination(for: RecommendationsSectionRouting<AppState>.self)
            .navigationDestination(for: RecommendationsRouting<AppState>.self)
    }
}

// MARK: - Targets

public extension ItemDetailsTarget {
    init?(item: any Item) {
        switch item {
        case let movie as Movie: self = .movie(movie.id)
        case let show as Show: self = .show(show.id)
        default: return nil
        }
    }
}

extension CastSectionTarget {
    init?(item: any Item) {
        switch item {
        case let movie as Movie: self = .movie(movie.id)
        case let show as Show: self = .show(show.id)
        default: return nil
        }
    }
}

extension RecomendationTarget {
    init?(item: any Item) {
        switch item {
        case let movie as Movie: self = .movie(movie.id)
        case let show as Show: self = .show(show.id)
        default: return nil
        }
    }
}

extension ReviewsTarget {
    init?(item: any Item) {
        switch item {
        case let movie as Movie: self = .movie(movie.id)
        case let show as Show: self = .show(show.id)
        default: return nil
        }
    }
}
