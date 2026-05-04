//
//  MovieCastContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct MovieCastContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsCastComponent

    let id: Movie.ID

    func scope(for state: AppState) -> Scope {
        state.movieCastFlow[id]
    }

    func map(store _: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            cast: cast,
            castById: { castById(id: $0) },
            isRedacted: isRedacted
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadItemCast(itemId: id).binded(to: self))
    }
}

// MARK: - Props

private extension MovieCastContainer {
    var flow: MovieCastFlow {
        store.state.movieCastFlow[id] ?? .init()
    }

    var cast: [Cast.ID] {
        if flow != .none {
            return Cast.fakeItems(count: 3).ids
        }
        return store.state.allCast.byMovieId[id]?.elements ?? []
    }

    func castById(id: Cast.ID) -> Cast {
        if flow != .none {
            return Cast.fakeItem()
        }
        return store.state.allCast.castBy(id: id)
    }

    var isRedacted: Bool {
        if case .loadMovieCast = flow, store.state.allCast.byMovieId[id]?.first == nil {
            return true
        }
        return false
    }
}
