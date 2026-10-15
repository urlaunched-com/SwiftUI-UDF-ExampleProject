//
//  ReviewsRouting.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

/// Routes the Reviews flow asks its host to resolve. Everything else is resolved inside the flow.
public enum ReviewsRoute: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}

/// Registers every screen of the flow that can be pushed onto the hosting navigation stack.
struct ReviewsDestinations<AppState: ReviewsFeature>: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: ReviewsSectionRouting<AppState>.self)
            .navigationDestination(for: ReviewsListRouting<AppState>.self)
    }
}
