//
//  SectionDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct SectionDetailsContainer<S: Section>: Container {
    typealias ContainerComponent = SectionDetailsComponent

    let section: S

    func scope(for state: AppState) -> Scope {
        state.sectionDetailsForm
        state.sectionDetailsFlow
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            title: section.title,
            items: items,
            genreById: store.state.allGenres.genreBy,
            loadMoreAction: loadNewPageIfNeeded,
            alertStatus: store.$state.homeForm.alert
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(
            ActionGroup {
                Actions.SectionOpened(sectionId: section.id)
                if let movieSection = section as? MovieSection {
                    Actions.SetPaginationItems(items: store.state.allMovies.moviesBySectionId[movieSection.id]?.elements ?? [], id: SectionDetailsFlow.loadMoviesId)
                    Actions.LoadPage(id: SectionDetailsFlow.loadMoviesId)
                } else if let showSection = section as? ShowSection {
                    Actions.SetPaginationItems(items: store.state.allShows.showsBySectionId[showSection.id]?.elements ?? [], id: SectionDetailsFlow.loadShowsId)
                    Actions.LoadPage(id: SectionDetailsFlow.loadShowsId)
                }
            }
        )
    }
}

// MARK: - Props

private extension SectionDetailsContainer {
    var isMovieSection: Bool { section is MovieSection }
    var isShowSection: Bool { section is ShowSection }

    var items: [any Item] {
        if isMovieSection {
            return store.state.sectionDetailsForm.movies.map { store.state.allMovies.movieBy(id: $0) }
        } else if isShowSection {
            return store.state.sectionDetailsForm.shows.map { store.state.allShows.showBy(id: $0) }
        }
        return []
    }

    func loadNewPageIfNeeded() {
        if isMovieSection {
            guard case let .number(currentPage) = store.state.sectionDetailsForm.moviesPage,
                  case .none = store.state.sectionDetailsFlow else { return }

            store.dispatch(
                Actions.LoadPage(
                    pageNumber: currentPage + 1,
                    id: SectionDetailsFlow.loadMoviesId
                )
            )
        } else if isShowSection {
            guard case let .number(currentPage) = store.state.sectionDetailsForm.showsPage,
                  case .none = store.state.sectionDetailsFlow else { return }

            store.dispatch(
                Actions.LoadPage(
                    pageNumber: currentPage + 1,
                    id: SectionDetailsFlow.loadShowsId
                )
            )
        }
    }
}
