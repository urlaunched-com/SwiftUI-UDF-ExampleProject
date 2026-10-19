//
//  SectionDetailsRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 14.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import UIKit
import Common
import Models
import SwiftUI
import UDFMacros

@AutoHashable
enum SectionDetailsRoute {
    case imageContainer(path: String?, size: CGSize)
    case itemDetails(any Item)
}

struct SectionDetailsRouting<AppState: HomeFeature>: Routing {
    @ViewBuilder func view(for route: SectionDetailsRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            AppState.HomeRouting().view(for: .itemDetails(item))
        case let .imageContainer(path, size):
            AppState.HomeRouting().view(for: .imageContainer(path: path, size: size))
        }
    }
}
