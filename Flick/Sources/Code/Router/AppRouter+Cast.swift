//
//  AppRouter+Cast.swift
//  Flick
//
//  Created by Bogdan Petkanych on 02.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import Cast
import UDF

extension AppRouter {
    struct CastRouting: Routing {
        @ViewBuilder func view(for route: CastRoute) -> some View {
            switch route {
            case let .imageContainer(path: path, size: size, type: type):
                AppRouter.image(size: size, path: path, type: type)
            }
        }
    }
}
