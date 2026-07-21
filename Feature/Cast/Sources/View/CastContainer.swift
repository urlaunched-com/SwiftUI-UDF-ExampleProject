//
//  CastContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public struct CastContainer<F: CastFeature, R: Routing>: Container where R.Route == CastRoute {
    public typealias ContainerComponent = CastComponent<R>

    public let cast: [Models.Cast.ID]

    public init(cast: [Models.Cast.ID]) {
        self.cast = cast
    }

    public func scope(for state: F) -> Scope {
        state.castForm
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            cast: cast,
            castById: store.state.allCast.castBy,
            dialogStatus: store.$state.castForm.dialog,
            router: R()
        )
    }
}
