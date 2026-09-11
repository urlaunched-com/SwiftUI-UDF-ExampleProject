//
//  ItemDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 17.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import Common
import SwiftUI

struct ItemDetailsContainer<F: ItemDetailsFeature>: BindableContainer {
    typealias ContainerComponent = ItemDetailsComponent<F.ItemDetailsFeatureRouting>

    let id: ItemDetailsTarget
    
    init(id: ItemDetailsTarget) {
        self.id = id
    }

    func scope(for state: F) -> Scope {
        state.itemDetailsFeatureState.itemDetailsForm[id]
        state.itemDetailsFeatureState.itemDetailsFlow[id]
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            item: item,
            genreById: store.state.allGenres.by(id:),
            dialog: dialog,
            router: .init(routing: F.ItemDetailsFeatureRouting())
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(
            ActionGroup {
                Actions.LoadItemDetails(item: id)
            }.binded(to: self)
        )
    }
}

private extension ItemDetailsContainer {
    var form: ItemDetailsForm {
        store.state.itemDetailsFeatureState.itemDetailsForm[id] ?? .init()
    }
    
    var flow: ItemDetailsFlow {
        store.state.itemDetailsFeatureState.itemDetailsFlow[id] ?? .init()
    }
    
    var item: any Item {
        switch id {
        case let .movie(movieID):
            store.state.allMovies.by(id: movieID)
        case let .show(showID):
            store.state.allShows.by(id: showID)
        }
    }
    
    var dialog: Binding<DialogStatus> {
        Binding {
            form.dialog
        } set: { newDialog in
            store.dispatch(Actions.UpdateFormField(keyPath: \ItemDetailsForm.dialog, value: newDialog))
        }
    }
}
