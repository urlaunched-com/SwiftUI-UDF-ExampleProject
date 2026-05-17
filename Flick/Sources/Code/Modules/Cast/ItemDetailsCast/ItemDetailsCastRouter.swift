//
//  ItemDetailsCastRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import ItemDetailsCastComponent

struct ItemDetailsCastRouting: Routing {
    @ViewBuilder func view(for route: ItemDetailsCastRoute) -> some View {
        switch route {
        case let .cast(cast): CastContainer(cast: cast)
        }
    }
}
