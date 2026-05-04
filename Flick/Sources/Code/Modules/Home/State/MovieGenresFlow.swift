//
//  MovieGenresFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 15.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import UDF

enum MovieGenresFlow: IdentifiableFlow {
    case none, loading

    init() { self = .loading }

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.DidLoadItems<Genre> where action.id == Self.id:
            self = .none

        default:
            break
        }
    }
}
