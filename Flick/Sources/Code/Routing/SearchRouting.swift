//
//  SearchRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Search
import Image

struct SearchRouting: Routing {
    @ViewBuilder func view(for route: SearchRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size):
            ImageContainer<AppState>(size: size, path: path)
        }
    }
}
