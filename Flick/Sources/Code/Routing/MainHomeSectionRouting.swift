//
//  MainHomeSectionRouting.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import MainHomeSection
import Image
import SectionDetails
import ItemDetails

struct MainHomeSectionRouting: Routing {
    @ViewBuilder func view(for route: MainHomeSectionRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            buildView(
                item: item,
                movieView: { ItemDetailsEntryPoint<AppState, ItemDetailsRouting>.make(with: .init(id: .movie($0.id))) },
                showView: { ItemDetailsEntryPoint<AppState, ItemDetailsRouting>.make(with: .init(id: .show($0.id))) }
            )

        case let .sectionDetails(section):
            if let movieSection = section as? MovieSection {
                SectionDetailsEntryPoint<AppState, MovieSection, SectionDetailsRouting>.make(with: .init(section: movieSection))
            } else if let showSection = section as? ShowSection {
                SectionDetailsEntryPoint<AppState, ShowSection, SectionDetailsRouting>.make(with: .init(section: showSection))
            }
        case let .imageContainer(path, size, type, isLoaderPresented):
            AppRouter.image(size: size, path: path, type: type, isLoaderPresented: isLoaderPresented)
        }
    }
}
