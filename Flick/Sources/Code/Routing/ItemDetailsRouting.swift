//
//  ItemDetailsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import ItemDetails

struct ItemDetailsRouting: Routing {
    @ViewBuilder func view(for route: ItemDetailsRoute) -> some View {
        switch route {
        case let .reviews(target):
            AppRouter.reviews(id: target)
        case let .imageContainer(path, size, type):
            AppRouter.image(size: size, path: path, type: type)
        }
    }
}
