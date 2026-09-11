//
//  MyFavoritesContainer.swift
//  Flick
//
//  Created by Vlad Andrieiev on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common

struct MyFavoritesContainer<F: MyFavoritesFeature>: Container {
    typealias ContainerComponent = MyFavoritesComponent<F.MyFavoritesRouting>

    init() {}

    func scope(for state: F) -> Scope {
        state.myFavoritesFeatureState.myFavoritesForm
        state.myFavoritesFeatureState.myFavoritesFlow
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            contentType: Binding(
                get: { store.state.myFavoritesFeatureState.myFavoritesForm.contentType },
                set: { setContentType($0) }
            ),
            items: items,
            genreById: { store.state.allGenres.by(id: $0) },
            loadMoreAction: loadNewPageIfNeeded,
            isRedacted: isRedacted,
            dialog: store.$state.myFavoritesFeatureState.myFavoritesForm.dialog
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadPage(id: MyFavoritesFlow.loadMoviesId))
    }
}

private extension MyFavoritesContainer {
    var items: [any Item] {
        if store.state.myFavoritesFeatureState.myFavoritesForm.contentType == .movie {
            return isRedacted ? Movie.fakeItems(count: 3) : movies
        } else {
            return isRedacted ? Show.fakeItems(count: 3) : shows
        }
    }

    var movies: [Movie] {
        store.state.myFavoritesFeatureState.myFavoritesForm.movies.map { store.state.allMovies.by(id: $0) }
    }

    var shows: [Show] {
        store.state.myFavoritesFeatureState.myFavoritesForm.shows.map { store.state.allShows.by(id: $0) }
    }

    var isRedacted: Bool {
        if case .loadMovies = store.state.myFavoritesFeatureState.myFavoritesFlow, movies.isEmpty {
            return true
        }
        if case .loadShows = store.state.myFavoritesFeatureState.myFavoritesFlow, shows.isEmpty {
            return true
        }
        return false
    }

    func setContentType(_ contentType: ContentType) {
        store.dispatch(
            Actions.UpdateFormField(keyPath: \MyFavoritesForm.contentType, value: contentType)
                .with(animation: .spring(blendDuration: 0.2)),
            priority: .userInteractive
        )
        store.dispatch(
            Actions.LoadPage(
                id: contentType == .movie
                    ? MyFavoritesFlow.loadMoviesId
                    : MyFavoritesFlow.loadShowsId
            )
        )
    }

    func loadNewPageIfNeeded() {
        store.state.myFavoritesFeatureState.myFavoritesForm.contentType == .movie ? loadMoreMovies() : loadMoreShows()
    }

    func loadMoreMovies() {
        guard case let .number(currentPage) = store.state.myFavoritesFeatureState.myFavoritesForm.moviesPage,
              case .none = store.state.myFavoritesFeatureState.myFavoritesFlow else {
            return
        }
        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: MyFavoritesFlow.loadMoviesId
            )
        )
    }

    func loadMoreShows() {
        guard case let .number(currentPage) = store.state.myFavoritesFeatureState.myFavoritesForm.showsPage,
              case .none = store.state.myFavoritesFeatureState.myFavoritesFlow else {
            return
        }
        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: MyFavoritesFlow.loadShowsId
            )
        )
    }
}
