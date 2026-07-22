//
//  RecommendationsSectionContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 05.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import Common

public struct RecommendationsSectionContainer<F: RecommendationsSectionFeature, R: Routing>: BindableContainer where R.Route == RecommendationsSectionRoute {
    public typealias ContainerComponent = RecommendationsSectionComponent<R>

    public let id: RecomendationTarget

    public init(id: RecomendationTarget) {
        self.id = id
    }
    
    public func scope(for state: F) -> Scope {
        state.recommendationsSectionBindableFlow[id]
        state.recommendationsSectionBindableForm[id]
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            item: item,
            items: items,
            isRedacted: isRedacted,
            genreById: store.state.allGenres.genreBy,
            router: R(),
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadPage(id: RecommendationsSectionFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension RecommendationsSectionContainer {
    var items: [any Item] {
        if isRedacted {
            switch id {
            case .movie:
                return Movie.fakeItems(count: 10)
            case .show:
                return Show.fakeItems(count: 10)
            }
        }
        return loadedItems
    }
    
    var loadedItems: [any Item] {
        switch id {
        case let .movie(movieID):
            let ids = store.state.allMovies.recommendationsByMovieId[movieID]?.elements ?? []
            return ids.map { store.state.allMovies.movieBy(id: $0) }
        case let .show(showID):
            let ids = store.state.allShows.recommendationsByShowId[showID]?.elements ?? []
            return ids.map { store.state.allShows.showBy(id: $0) }
        }
    }
    
    var item: any Item {
        switch id {
        case let .movie(movieID):
            return store.state.allMovies.movieBy(id: movieID)
        case let .show(showID):
            return store.state.allShows.showBy(id: showID)
        }
    }
    
    var flow: RecommendationsSectionFlow {
        store.state.recommendationsSectionBindableFlow[id] ?? .init()
    }
    
    var form: RecommendationsSectionForm {
        store.state.recommendationsSectionBindableForm[id] ?? .init()
    }

    var isRedacted: Bool {
        if case .load = flow, loadedItems.isEmpty {
            return true
        }
        return false
    }
}
