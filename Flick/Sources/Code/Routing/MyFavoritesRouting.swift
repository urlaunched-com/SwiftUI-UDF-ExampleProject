//
//  MyFavoritesRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.

import SwiftUI
import UDF
import MyFavorites

struct MyFavoritesRouting: Routing {
    @ViewBuilder func view(for route: MyFavoritesRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            AppRouter.image(size: size, path: path, type: type)
        }
    }
}
