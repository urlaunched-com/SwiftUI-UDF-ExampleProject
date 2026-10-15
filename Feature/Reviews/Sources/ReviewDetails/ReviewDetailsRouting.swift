//
//  Router.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UIKit
import SwiftUI
import UDF

enum ReviewDetailsRoute: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .profile)
}

struct ReviewDetailsRouting<AppState: ReviewsFeature>: Routing {
    @ViewBuilder func view(for route: ReviewDetailsRoute) -> some View {
        switch route {
        case let .imageContainer(path, size, type):
            AppState.ReviewsRouting().view(for: .imageContainer(path: path, size: size, type: type))
        }
    }
}
