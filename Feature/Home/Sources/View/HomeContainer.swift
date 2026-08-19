//
//  HomeContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Models
import SwiftUI
import UDF

public struct HomeContainer<F: HomeFeature, R: Routing>: Container where R.Route == HomeRoute {
    public typealias ContainerComponent = HomeComponent<R>

    public init() {}

    public func scope(for state: F) -> Scope {
        state.homeForm
        state.homeFlow
        state.allMovies
        state.allShows
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            contentType: Binding(
                get: { store.state.homeForm.contentType },
                set: {
                    store.dispatch(
                        Actions.UpdateFormField(keyPath: \F.HomeForm.contentType, value: $0)
                            .with(animation: .spring(blendDuration: 0.2)),
                        priority: .userInteractive
                    )
                }
            ),
            movieSections: MovieSection.allCases,
            showSections: ShowSection.allCases,
            moviesForSection: { isMoviesRedacted(section: $0) ? Movie.fakeItems(count: 3) : moviesForSection($0, store: store) },
            showsForSection: { isShowsRedacted(section: $0) ? Show.fakeItems(count: 3) : showsForSection($0, store: store) },
            isMoviesRedacted: { isMoviesRedacted(section: $0) },
            isShowsRedacted: { isShowsRedacted(section: $0) },
            dialogStatus: store.$state.homeForm.dialog,
            router: .init(routing: R())
        )
    }
}

private extension HomeContainer {
    func moviesForSection(_ section: MovieSection, store: EnvironmentStore<F>) -> [Movie] {
        guard let moviesBySection = store.state.allMovies.moviesBySectionId[section] else {
            return []
        }

        return moviesBySection.compactMap { movieId in
            store.state.allMovies.byId[movieId]
        }
    }

    func showsForSection(_ section: ShowSection, store: EnvironmentStore<F>) -> [Show] {
        guard let showsBySection = store.state.allShows.showsBySectionId[section] else {
            return []
        }

        return showsBySection.compactMap { showId in
            store.state.allShows.byId[showId]
        }
    }

    func isMoviesRedacted(section: MovieSection) -> Bool {
        store.state.homeFlow.isLoading && moviesForSection(section, store: store).isEmpty
    }

    func isShowsRedacted(section: ShowSection) -> Bool {
        store.state.homeFlow.isLoading && showsForSection(section, store: store).isEmpty
    }
}
