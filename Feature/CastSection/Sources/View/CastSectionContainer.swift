//
//  CastSectionContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Image
import Models
import UDF

public struct CastSectionContainer<F: CastSectionFeature & ImageFeature, R: Routing>: BindableContainer where R.Route == CastSectionRoute {
    public typealias ContainerComponent = CastSectionComponent<R>

    public let id: CastSectionTarget

    public init(id: CastSectionTarget) {
        self.id = id
    }

    public func scope(for state: F) -> Scope {
        state.allCast
        state.castSectionBindableFlow[id]
    }

    public func map(store _: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            cast: cast,
            castById: castById,
            isRedacted: isRedacted,
            router: .init()
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(ActionGroup {
            switch id {
            case let .movie(movieId):
                Actions.LoadItemCast(itemId: movieId)
            case let .show(showId):
                Actions.LoadItemCast(itemId: showId)
            }
        }.binded(to: self))
    }
}

private extension CastSectionContainer {
    var flow: CastSectionFlow {
        store.state.castSectionBindableFlow[id] ?? .init()
    }

    var cast: [Cast.ID] {
        if flow != .none {
            return Cast.fakeItems(count: 3).ids
        }

        switch id {
        case let .movie(movieId):
            return store.state.allCast.byMovieId[movieId]?.elements ?? []
        case let .show(showId):
            return store.state.allCast.byShowId[showId]?.elements ?? []
        }
    }

    func castById(_ id: Cast.ID) -> Cast {
        if flow != .none {
            return .fakeItem()
        }
        return store.state.allCast.castBy(id: id)
    }

    var isRedacted: Bool {
        switch (id, flow) {
        case let (.movie(movieId), .loadMovieCast) where store.state.allCast.byMovieId[movieId]?.first == nil:
            return true
        case let (.show(showId), .loadShowCast) where store.state.allCast.byShowId[showId]?.first == nil:
            return true
        default:
            return false
        }
    }
}
