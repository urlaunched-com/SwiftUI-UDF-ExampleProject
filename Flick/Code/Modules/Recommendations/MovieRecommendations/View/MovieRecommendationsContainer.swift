//
//  MovieRecommendationsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 06.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct MovieRecommendationsContainer: BindableContainer {
    typealias ContainerComponent = SectionDetailsComponent

    let id: Movie.ID

    func scope(for state: AppState) -> Scope {
        state.movieRecommendationsFlow[id]
        state.movieRecommendationsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            title: "",
            items: movies,
            genreById: store.state.allGenres.genreBy,
            loadMoreAction: loadNewPageIfNeeded,
            alertStatus: store.$state.movieRecommendationsForm[id].alert
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(
            ActionGroup {
                Actions.SetPaginationItems(
                    items: store.state.allMovies.recommendationsByMovieId[id]?.elements ?? [],
                    id: MovieRecommendationsFlow.id
                )
                Actions.LoadPage(id: MovieRecommendationsFlow.id)
            }.binded(to: self)
        )
    }
}

// MARK: - Props

private extension MovieRecommendationsContainer {
    var form: MovieRecommendationsForm {
        store.state.movieRecommendationsForm[id] ?? .init()
    }

    var flow: MovieRecommendationsFlow {
        store.state.movieRecommendationsFlow[id] ?? .init()
    }

    var movies: [Movie] {
        let ids = store.state.allMovies.recommendationsByMovieId[id]?.elements ?? []
        return ids.map { store.state.allMovies.movieBy(id: $0) }
    }

    func loadNewPageIfNeeded() {
        guard case let .number(currentPage) = form.page, case .none = flow else { return }

        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: MovieRecommendationsFlow.id
            ).binded(to: self)
        )
    }
}
