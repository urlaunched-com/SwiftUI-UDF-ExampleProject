//
//  MyFavoritesContainer.swift
//  Flick
//
//  Created by Vlad Andrieiev on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct MyFavoritesContainer: Container {
    typealias ContainerComponent = MyFavoritesComponent

    func scope(for state: AppState) -> Scope {
        state.myFavoritesForm
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            contentType: Binding(
                get: { store.state.myFavoritesForm.contentType },
                set: { setContentType($0) }
            ),
            items: items,
            genreById: { store.state.allGenres.byId[$0] },
            loadMoreAction: loadNewPageIfNeeded,
            isRedacted: isRedacted,
            alertStatus: store.$state.myFavoritesForm.alert
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPage(id: MyFavoritesFlow.loadMoviesId))
    }
}

// MARK: - items

private extension MyFavoritesContainer {
    var items: [any Item] {
        if store.state.myFavoritesForm.contentType == .movie {
            return isRedacted ? Movie.fakeItems(count: 3) : movies
        } else {
            return isRedacted ? Show.fakeItems(count: 3) : shows
        }
    }

    var movies: [Movie] {
        store.state.myFavoritesForm.movies.compactMap { store.state.allMovies.byId[$0] }
    }

    var shows: [Show] {
        store.state.myFavoritesForm.shows.compactMap { store.state.allShows.byId[$0] }
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
            Actions.LoadPage(id: contentType == .movie ? MyFavoritesFlow.loadMoviesId : MyFavoritesFlow.loadShowsId)
        )
    }

    func loadNewPageIfNeeded() {
        store.state.myFavoritesForm.contentType == .movie ? loadMoreMovies() : loadMoreShows()
    }

    func loadMoreMovies() {
        guard case let .number(currentPage) = store.state.myFavoritesForm.moviesPage,
              case .none = store.state.myFavoritesFlow else { return }
        store.dispatch(Actions.LoadPage(pageNumber: currentPage + 1, id: MyFavoritesFlow.loadMoviesId))
    }

    func loadMoreShows() {
        guard case let .number(currentPage) = store.state.myFavoritesForm.showsPage,
              case .none = store.state.myFavoritesFlow else { return }
        store.dispatch(Actions.LoadPage(pageNumber: currentPage + 1, id: MyFavoritesFlow.loadShowsId))
    }
}
