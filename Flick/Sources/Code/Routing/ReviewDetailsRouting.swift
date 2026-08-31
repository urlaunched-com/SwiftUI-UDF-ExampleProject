//
//  ReviewDetailsRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import Models
import ReviewDetails
import Image

struct ReviewDetailsRouting: Routing {
    @ViewBuilder func view(for route: ReviewDetailsRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            ImageEntryPoint<AppState>.make(with: .init(size: size, path: path, type: type))
        }
    }
}
