//
//  HomeFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 30.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

enum HomeFlow: IdentifiableFlow {
    case none, loading

    init() { self = .none }

    mutating func reduce(_ action: some Action) {
        switch action {
        case is Actions.LoadHomeSection<MovieSection>:
            self = .loading

        case is Actions.LoadHomeSection<ShowSection>:
            self = .loading

        case is Actions.DidLoadItems<Movie>:
            self = .none

        case is Actions.DidLoadItems<Show>:
            self = .none

        default:
            break
        }
    }
}
