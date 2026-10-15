//
//  SectionDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import Common
import SwiftUI

struct SectionDetailsContainer<F: HomeFeature>: Container {
    typealias ContainerComponent = SectionDetailsComponent<SectionDetailsRouting<F>>
    let section: any Models.Section

    func scope(for state: F) -> Scope {
        state.homeFeatureState.sectionDetailsForm
        state.homeFeatureState.sectionDetailsFlow
    }
    
    init(section: any Models.Section) {
        self.section = section
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            title: section.title,
            items: items,
            genreById: store.state.allGenres.by(id:),
            loadMoreAction: loadNewPageIfNeeded,
            dialog: dialog
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(
            ActionGroup {
                if let movieSection = section as? MovieSection {
                    Actions.SectionOpened(sectionId: movieSection.id)
                    Actions.SetPaginationItems(items: store.state.allMovies.moviesBySectionId[movieSection.id]?.elements ?? [], id: SectionDetailsFlow.loadMoviesId)
                    Actions.LoadPage(id: SectionDetailsFlow.loadMoviesId)
                } else if let showSection = section as? ShowSection {
                    Actions.SectionOpened(sectionId: showSection.id)
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
            return store.state.homeFeatureState.sectionDetailsForm.movies.map { store.state.allMovies.by(id: $0) }
        } else if isShowSection {
            return store.state.homeFeatureState.sectionDetailsForm.shows.map { store.state.allShows.by(id: $0) }
        }
        return []
    }
    
    var dialog: Binding<DialogStatus> {
        Binding {
            store.state.homeFeatureState.homeForm.dialog
        } set: { newDialog in
            store.dispatch(Actions.UpdateFormField(keyPath: \HomeForm.dialog, value: newDialog))
        }

    }

    func loadNewPageIfNeeded() {
        if isMovieSection {
            guard case let .number(currentPage) = store.state.homeFeatureState.sectionDetailsForm.moviesPage,
                  case .none = store.state.homeFeatureState.sectionDetailsFlow else { return }

            store.dispatch(
                Actions.LoadPage(
                    pageNumber: currentPage + 1,
                    id: SectionDetailsFlow.loadMoviesId
                )
            )
        } else if isShowSection {
            guard case let .number(currentPage) = store.state.homeFeatureState.sectionDetailsForm.showsPage,
                  case .none = store.state.homeFeatureState.sectionDetailsFlow else { return }

            store.dispatch(
                Actions.LoadPage(
                    pageNumber: currentPage + 1,
                    id: SectionDetailsFlow.loadShowsId
                )
            )
        }
    }
}
