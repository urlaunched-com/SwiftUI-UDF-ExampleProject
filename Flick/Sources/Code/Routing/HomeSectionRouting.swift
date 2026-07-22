//
//  HomeSectionRouting.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import HomeSection
import Image
import SectionDetails

struct HomeSectionRouting: Routing {
    @ViewBuilder func view(for route: HomeSectionRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            buildView(
                item: item,
                movieView: { MovieDetailsContainer(id: $0.id) },
                showView: { ShowDetailsContainer(id: $0.id) }
            )

        case let .sectionDetails(section):
            if let movieSection = section as? MovieSection {
                SectionDetailsContainer<AppState, MovieSection, SectionDetailsRouting>(section: movieSection)
            } else if let showSection = section as? ShowSection {
                SectionDetailsContainer<AppState, ShowSection, SectionDetailsRouting>(section: showSection)
            }
        case let .imageContainer(path, size, type):
            ImageContainer<AppState>(size: size, path: path, type: type)
        }
    }
}
