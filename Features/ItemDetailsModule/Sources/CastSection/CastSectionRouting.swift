//
//  CastSectionRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import Models
import UIKit
import Common
import SwiftUI
import UDF

enum CastSectionRoute: Hashable {
    case cast([Cast.ID])
    case imageContainer(path: String?, size: CGSize, type: ImageType = .profile)
}

struct CastSectionRouting<AppState: ItemDetailsFeature>: Routing {
    @ViewBuilder func view(for route: CastSectionRoute) -> some View {
        switch route {
        case let .cast(ids):
            CastContainer<AppState>(cast: ids)
        case let .imageContainer(path, size, type):
            AppState.ItemDetailsRouting().view(for: .imageContainer(path: path, size: size, type: type))
        }
    }
}
