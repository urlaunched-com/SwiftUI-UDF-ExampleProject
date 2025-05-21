//
//  ShowCastContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct ShowCastContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsCastComponent

    let id: Show.ID

    func scope(for state: AppState) -> Scope {
        state.showCastFlow[id]
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

private extension ShowCastContainer {
    var flow: ShowCastFlow {
        store.state.showCastFlow[id] ?? .init()
    }

    var cast: [Cast.ID] {
        if flow != .none {
            return Cast.fakeItems(count: 3).ids
        }
        return store.state.allCast.byShowId[id]?.elements ?? []
    }

    func castById(id: Cast.ID) -> Cast {
        if flow != .none {
            return Cast.fakeItem()
        }
        return store.state.allCast.castBy(id: id)
    }

    var isRedacted: Bool {
        if case .loadShowCast = flow, store.state.allCast.byShowId[id]?.first == nil {
            return true
        }
        return false
    }
}
