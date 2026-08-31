//
//  CastRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Cast
import Image

struct CastRouting: Routing {
    @ViewBuilder func view(for route: CastRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            ImageEntryPoint<AppState>.make(with: .init(size: size, path: path, type: type))
        }
    }
}
