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
import SwiftFoundation

struct RecommendationsSectionContainer<F: ItemDetailsFeature>: BindableContainer {
    typealias ContainerComponent = RecommendationsSectionComponent<RecommendationsSectionRouting<F>>

    let id: RecomendationTarget

    init(id: RecomendationTarget) {
        self.id = id
    }
    
    func scope(for state: F) -> Scope {
        state.itemDetailsFeatureState.recommendationsSectionFlow[id]
        state.itemDetailsFeatureState.recommendationsSectionForm[id]
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            item: item,
            items: items,
            isRedacted: isRedacted,
            genreById: store.state.allGenres.by(id:),
            router: .init(routing: RecommendationsSectionRouting<F>()),
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
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
            return ids.map { store.state.allMovies.by(id: $0) }
        case let .show(showID):
            let ids = store.state.allShows.recommendationsByShowId[showID]?.elements ?? []
            return ids.map { store.state.allShows.by(id: $0) }
        }
    }
    
    var item: any Item {
        switch id {
        case let .movie(movieID):
            return store.state.allMovies.by(id: movieID)
        case let .show(showID):
            return store.state.allShows.by(id: showID)
        }
    }
    
    var flow: RecommendationsSectionFlow {
        store.state.itemDetailsFeatureState.recommendationsSectionFlow[id] ?? .init()
    }
    
    var form: RecommendationsSectionForm {
        store.state.itemDetailsFeatureState.recommendationsSectionForm[id] ?? .init()
    }

    var isRedacted: Bool {
        if case .load = flow, loadedItems.isEmpty {
            return true
        }
        return false
    }
}
