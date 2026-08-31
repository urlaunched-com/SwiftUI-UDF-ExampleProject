//
//  CastSectionRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
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
            ImageEntryPoint<AppState>.make(with: .init(size: size, path: path, type: type))
        case let .cast(ids):
            CastEntryPoint<AppState, CastRouting>.make(with: .init(cast: ids))
        }
    }
}
