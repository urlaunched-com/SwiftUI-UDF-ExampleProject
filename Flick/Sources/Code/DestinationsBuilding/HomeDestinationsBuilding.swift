//
//  HomeDestinationBuilder.swift
//  Flick
//
//  Created by Bogdan Petkanych on 23.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Root
import SwiftUI

struct HomeDestinationBuilder: Root.HomeDestinationBuilder {
    struct DestinationModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .navigationDestination(for: HomeRouting.self)
                .navigationDestination(for: MainHomeSectionRouting.self)
                .navigationDestination(for: HomeSectionRouting.self)
                .navigationDestination(for: SectionDetailsRouting.self)
                .navigationDestination(for: ItemDetailsRouting.self)
                .navigationDestination(for: ReviewsRouting.self)
                .navigationDestination(for: ReviewsSectionRouting.self)
                .navigationDestination(for: RecommendationsSectionRouting.self)
                .navigationDestination(for: ReviewsRouting.self)
                .navigationDestination(for: CastSectionRouting.self)
        }
    }

    func makeDestinationModifier() -> DestinationModifier {
        DestinationModifier()
    }
}
