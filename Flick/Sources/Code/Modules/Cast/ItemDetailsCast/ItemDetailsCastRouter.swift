//
//  ItemDetailsCastRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
@preconcurrency import Models

struct ItemDetailsCastRouting: Routing {
    enum Route: Hashable {
        case cast([Cast.ID])
    }

    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case let .cast(cast): CastContainer(cast: cast)
        }
    }
}
