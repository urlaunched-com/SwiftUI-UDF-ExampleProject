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

public struct MyFavoritesContainer<F: MyFavoritesFeature, R: Routing>: Container where R.Route == MyFavoritesRoute {
    public typealias ContainerComponent = MyFavoritesComponent<R>

    public init() {}

    public func scope(for state: F) -> Scope {
        state.myFavoritesForm
        state.myFavoritesFlow
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            contentType: Binding(
                get: { store.state.myFavoritesForm.contentType },
                set: { setContentType($0) }
            ),
            items: items,
            genreById: { store.state.allGenres.by(id: $0) },
            loadMoreAction: loadNewPageIfNeeded,
            isRedacted: isRedacted,
            dialog: store.$state.myFavoritesForm.dialog,
            router: R()
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadPage(id: MyFavoritesFlow.loadMoviesId))
        print("onContainerDidLoad(store: EnvironmentStore<F>)")
    }
}

private extension MyFavoritesContainer {
    var items: [any Item] {
        if store.state.myFavoritesForm.contentType == .movie {
            return isRedacted ? Movie.fakeItems(count: 3) : movies
        } else {
            return isRedacted ? Show.fakeItems(count: 3) : shows
        }
    }

    var movies: [Movie] {
        store.state.myFavoritesForm.movies.map { store.state.allMovies.by(id: $0) }
    }

    var shows: [Show] {
        store.state.myFavoritesForm.shows.map { store.state.allShows.by(id: $0) }
    }

    var isRedacted: Bool {
        if case .loadMovies = store.state.myFavoritesFlow, movies.isEmpty {
            return true
        }
        if case .loadShows = store.state.myFavoritesFlow, shows.isEmpty {
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
        store.state.myFavoritesForm.contentType == .movie ? loadMoreMovies() : loadMoreShows()
    }

    func loadMoreMovies() {
        guard case let .number(currentPage) = store.state.myFavoritesForm.moviesPage,
              case .none = store.state.myFavoritesFlow else {
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
        guard case let .number(currentPage) = store.state.myFavoritesForm.showsPage,
              case .none = store.state.myFavoritesFlow else {
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
