//
//  ShowDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct ShowDetailsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsComponent

    let id: Show.ID

    func scope(for state: AppState) -> Scope {
        state.showDetailsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allShows.showBy(id: id),
            genreById: store.state.allGenres.genreBy,
            alert: store.$state.showDetailsForm[id].alert
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(
            ActionGroup {
                Actions.UpdateFormField(keyPath: \ShowDetailsForm.showId, value: id)
                Actions.LoadItemDetails(itemId: id)
            }.binded(to: self)
        )
    }
}
