//
//  MovieDetailsRecommendationsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 05.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct MovieDetailsRecommendationsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsRecommendationsComponent

    let id: Movie.ID

    func scope(for state: AppState) -> Scope {
        state.movieDetailsRecommendationsFlow[id]
        state.movieDetailsRecommendationsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allMovies.movieBy(id: id),
            items: isRedacted ? Movie.fakeItems(count: 3) : movies,
            isRedacted: isRedacted,
            genreById: store.state.allGenres.genreBy
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPage(id: MovieRecommendationsFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension MovieDetailsRecommendationsContainer {
    var flow: MovieRecommendationsFlow {
        store.state.movieDetailsRecommendationsFlow[id] ?? .init()
    }

    var movies: [Movie] {
        let ids = store.state.allMovies.recommendationsByMovieId[id]?.elements ?? []
        return ids.map { store.state.allMovies.movieBy(id: $0) }
    }

    var isRedacted: Bool {
        if case .loadMovies = flow, movies.isEmpty {
            return true
        }
        return false
    }
}
