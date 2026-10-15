//
//  HomeRouting.swift
//  Flick
//
//  Created by Alexander Sharko on 18.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Home
import ItemDetails

struct HomeRouting: Routing {
    @ViewBuilder func view(for route: HomeRoute) -> some View {
        switch route {
        case let .itemDetails(item):
            if let target = ItemDetailsTarget(item: item) {
                AppRouter.itemDetails(id: target)
            }
        case let .imageContainer(path, size, type, isLoaderPresented):
            AppRouter.image(size: size, path: path, type: type, isLoaderPresented: isLoaderPresented)
        }
    }
}
