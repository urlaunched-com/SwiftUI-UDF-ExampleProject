//
//  SectionDetailsRouter.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import SectionDetails
import ItemDetails

struct SectionDetailsRouting: Routing {
    typealias Route = SectionDetailsRoute
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case let .itemDetails(item):
            if let movie = item as? Movie {
                ItemDetailsEntryPoint<AppState, ItemDetailsRouting>.make(with: .init(id: .movie(movie.id)))
            } else if let show = item as? Show {
                ItemDetailsEntryPoint<AppState, ItemDetailsRouting>.make(with: .init(id: .show(show.id)))
            }
        case .imageContainer(path: let path, size: let size):
            AppRouter.image(size: size, path: path)
        }
    }
}
