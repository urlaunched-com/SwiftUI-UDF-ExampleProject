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

public struct CastContainer<F: CastFeature>: Container {
    public typealias ContainerComponent = CastComponent<F.CastFeatureNavigation.Routing>

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
            castById: store.state.allCast.by(id:),
            dialogStatus: store.$state.castForm.dialog,
            router: .init(routing: store.state.castNavigation.routing)
        )
    }
}
