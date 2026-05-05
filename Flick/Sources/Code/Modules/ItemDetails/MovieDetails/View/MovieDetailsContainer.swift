//
//  MovieDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 17.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

struct MovieDetailsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsComponent

    let id: Movie.ID

    func scope(for state: AppState) -> Scope {
        state.movieDetailsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allMovies.movieBy(id: id),
            genreById: store.state.allGenres.genreBy,
            dialog: store.$state.movieDetailsForm[id].dialog
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
