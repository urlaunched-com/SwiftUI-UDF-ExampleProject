//
//  CastContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models
import Common

struct CastContainer<F: ItemDetailsFeature>: Container {
    typealias ContainerComponent = CastComponent<CastRouting<F>>

    let cast: [Models.Cast.ID]

    init(cast: [Models.Cast.ID]) {
        self.cast = cast
    }

    func scope(for state: F) -> Scope {
        state.itemDetailsFeatureState.castForm
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            cast: cast,
            castById: store.state.allCast.by(id:),
            dialogStatus: store.$state.itemDetailsFeatureState.castForm.dialog
        )
    }
}
