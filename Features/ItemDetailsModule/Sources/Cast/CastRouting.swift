//
//  CastRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UIKit
import SwiftUI
import UDF

enum CastRoute: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .profile)
}

struct CastRouting<AppState: ItemDetailsFeature>: Routing {
    @ViewBuilder func view(for route: CastRoute) -> some View {
        switch route {
        case let .imageContainer(path, size, type):
            AppState.ItemDetailsRouting().view(for: .imageContainer(path: path, size: size, type: type))
        }
    }
}
