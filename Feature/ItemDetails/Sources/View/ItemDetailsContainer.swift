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

public struct ItemDetailsContainer<F: ItemDetailsFeature, R: Routing>: BindableContainer where R.Route == ItemDetailsRoute {
    public typealias ContainerComponent = ItemDetailsComponent<R>

    public let id: ItemDetailsTarget
    
    public init(id: ItemDetailsTarget) {
        self.id = id
    }

    public func scope(for state: F) -> Scope {
        state.itemDetailsBindableForm[id]
        state.itemDetailsBindableFlow[id]
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            item: item,
            genreById: store.state.allGenres.by(id:),
            dialog: dialog,
            router: .init(routing: R())
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(
            ActionGroup {
                Actions.LoadItemDetails(item: id)
            }.binded(to: self)
        )
    }
}

private extension ItemDetailsContainer {
    var form: ItemDetailsForm {
        store.state.itemDetailsBindableForm[id] ?? .init()
    }
    
    var flow: ItemDetailsFlow {
        store.state.itemDetailsBindableFlow[id] ?? .init()
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
