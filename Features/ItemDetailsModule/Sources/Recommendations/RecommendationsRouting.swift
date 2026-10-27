//
//  RecommendationsRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UIKit
import Models
import Common
import SwiftUI
import UDF
import UDFMacros

@AutoHashable
enum RecommendationsRoute {
    case imageContainer(path: String?, size: CGSize)
    case itemDetails(any Item)
}

struct RecommendationsRouting<AppState: ItemDetailsFeature>: Routing {
    @ViewBuilder func view(for route: RecommendationsRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            if let target = ItemDetailsTarget(item: item) {
                ItemDetailsContainer<AppState>(id: target)
            }
        case let .imageContainer(path, size):
            AppState.ItemDetailsRouting().view(for: .imageContainer(path: path, size: size))
        }
    }
}
