//
//  CastSectionRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 03.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Cast
import Image
import CastSection

struct CastSectionRouting: Routing {
    @ViewBuilder func view(for route: CastSectionRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            AppRouter.image(size: size, path: path)
        case let .cast(ids):
            AppRouter.cast(ids: ids)
        }
    }
}
