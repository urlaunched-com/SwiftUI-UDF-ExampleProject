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

struct CastContainer<F: CastFeature>: Container {
    typealias ContainerComponent = CastComponent<F.CastFeatureRouting>

    let cast: [Models.Cast.ID]

    init(cast: [Models.Cast.ID]) {
        self.cast = cast
    }

    func scope(for state: F) -> Scope {
        state.castFeatureState.castForm
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            cast: cast,
            castById: store.state.allCast.by(id:),
            dialogStatus: store.$state.castFeatureState.castForm.dialog
        )
    }
}
