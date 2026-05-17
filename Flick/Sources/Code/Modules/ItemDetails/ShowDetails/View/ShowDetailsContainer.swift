//
//  ShowDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import ItemDetailsComponent
import Common

struct ShowDetailsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsComponent<ItemDetailsRouting>

    let id: Show.ID

    func scope(for state: AppState) -> Scope {
        state.showDetailsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allShows.showBy(id: id),
            genreById: store.state.allGenres.genreBy,
            dialog: store.$state.showDetailsForm[id].dialog,
            router: .init(),
            destinationBuilder: DestinationBuilder<ItemDetailsContent>(destination: { value in
                switch value {
                case let .imageContainer(path: path, size: size, type: type):
                    ImageContainer(size: size, path: path, type: type)
                }
            })
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
