//
//  HomeContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 30.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct HomeContainer: Container {
    typealias ContainerComponent = HomeComponent

    func scope(for state: AppState) -> Scope {
        state.homeForm
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            contentType: Binding(
                get: { store.state.homeForm.contentType },
                set: {
                    store.dispatch(
                        Actions.UpdateFormField(keyPath: \HomeForm.contentType, value: $0)
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
            alertStatus: store.$state.homeForm.alert
        )
    }
}

// MARK: - itemsForSection

private extension HomeContainer {
    func moviesForSection(_ section: MovieSection, store: EnvironmentStore<AppState>) -> [Movie] {
        guard let moviesBySection = store.state.allMovies.moviesBySectionId[section] else {
            return []
        }
        return moviesBySection.compactMap { movieId in
            store.state.allMovies.byId[movieId]
        }
    }

    func showsForSection(_ section: ShowSection, store: EnvironmentStore<AppState>) -> [Show] {
        guard let showsBySection = store.state.allShows.showsBySectionId[section] else {
            return []
        }
        return showsBySection.compactMap { showId in
            store.state.allShows.byId[showId]
        }
    }

    func isMoviesRedacted(section: MovieSection) -> Bool {
        store.state.homeFlow == .loading && moviesForSection(section, store: store).isEmpty
    }

    func isShowsRedacted(section: ShowSection) -> Bool {
        store.state.homeFlow == .loading && showsForSection(section, store: store).isEmpty
    }
}
