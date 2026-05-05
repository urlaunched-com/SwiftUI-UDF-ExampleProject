//
//  CastContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models

struct CastContainer: Container {
    typealias ContainerComponent = CastComponent

    let cast: [Cast.ID]

    func scope(for state: AppState) -> Scope {
        state.castForm
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            cast: cast,
            castById: store.state.allCast.castBy,
            dialogStatus: store.$state.castForm.dialog
        )
    }
}
