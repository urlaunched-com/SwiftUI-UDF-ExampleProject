//
//  ReviewsRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 03.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Reviews

struct ReviewsRouting: Routing {
    @ViewBuilder func view(for route: ReviewsRoute) -> some View {
        switch route {
        case let .imageContainer(path, size, type):
            AppRouter.image(size: size, path: path, type: type)
        }
    }
}
