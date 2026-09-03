//
//  AppRouter+ReviewDetails.swift
//  Flick
//
//  Created by Bogdan Petkanych on 01.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
import SwiftUI
import ReviewDetails
import Image

struct ReviewDetailsRouting: Routing {
    @ViewBuilder func view(for route: ReviewDetailsRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            AppRouter.image(size: size, path: path, type: type)
        }
    }
}
