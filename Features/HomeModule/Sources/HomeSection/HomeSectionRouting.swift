//
//  HomeSectionRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import UDFMacros

@AutoHashable
enum HomeSectionRoute {
    case itemDetails(any Item)
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}

struct HomeSectionRouting<AppState: HomeFeature>: Routing {
    @ViewBuilder func view(for route: HomeSectionRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            AppState.HomeRouting().view(for: .itemDetails(item))
        case let .imageContainer(path, size, type):
            AppState.HomeRouting().view(for: .imageContainer(path: path, size: size, type: type))
        }
    }
}
