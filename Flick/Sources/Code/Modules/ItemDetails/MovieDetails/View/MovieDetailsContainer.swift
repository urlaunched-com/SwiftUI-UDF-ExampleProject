//
//  MovieDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 17.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import Common
import ItemDetailsComponent

struct MovieDetailsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsComponent<ItemDetailsRouting>

    let id: Movie.ID

    func scope(for state: AppState) -> Scope {
        state.movieDetailsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allMovies.movieBy(id: id),
            genreById: store.state.allGenres.genreBy,
            dialog: store.$state.movieDetailsForm[id].dialog,
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
                Actions.UpdateFormField(keyPath: \MovieDetailsForm.movieId, value: id)
                Actions.LoadItemDetails(itemId: id)
            }.binded(to: self)
        )
    }
}
