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
                movieView: { ItemDetailsFeatureState<AppState, ItemDetailsRouting>.entryPoint(input: .movie($0.id)) },
                showView: { ItemDetailsFeatureState<AppState, ItemDetailsRouting>.entryPoint(input: .show($0.id)) }
            )

        case let .sectionDetails(section):
            AppRouter.sectionDetails(section: section)
        case let .imageContainer(path, size, type, isLoaderPresented):
            AppRouter.image(size: size, path: path, type: type, isLoaderPresented: isLoaderPresented)
        }
    }
}
