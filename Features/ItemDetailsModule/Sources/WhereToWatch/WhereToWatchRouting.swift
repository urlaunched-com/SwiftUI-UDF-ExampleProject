//
//  Router.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UIKit
import Common
import SwiftUI
import UDF

enum WhereToWatchRoute: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}

struct WhereToWatchRouting<AppState: ItemDetailsFeature>: Routing {
    @ViewBuilder func view(for route: WhereToWatchRoute) -> some View {
        switch route {
        case let .imageContainer(path, size, type):
            AppState.ItemDetailsRouting().view(for: .imageContainer(path: path, size: size, type: type))
        }
    }
}
