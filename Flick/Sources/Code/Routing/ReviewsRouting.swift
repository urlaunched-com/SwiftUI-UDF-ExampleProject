//
//  ReviwsRouting.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import SwiftUI
import Reviews
import ReviewDetails
import UDF
import Image

struct ReviewsRouting: Routing {
    @ViewBuilder func view(for route: ReviewsRoute) -> some View {
        switch route {
        case let .imageContainer(path: path, size: size, type: type):
            ImageEntryPoint<AppState>.make(with: .init(size: size, path: path, type: type))
        case let .reviewDetails(reviewID):
            ReviewDetailsEntryPoint<AppState, ReviewDetailsRouting>.make(with: .init(reviewID: reviewID))
        }
    }
}
