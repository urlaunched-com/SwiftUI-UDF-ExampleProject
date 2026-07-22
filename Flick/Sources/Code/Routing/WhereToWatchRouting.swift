//
//  WhereToWatchRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import WhereToWatch
import Image

struct WhereToWatchRouting: Routing {
    @ViewBuilder func view(for route: WhereToWatchRouter) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            ImageContainer<AppState>(size: size, path: path, type: type)
        }
    }
}
