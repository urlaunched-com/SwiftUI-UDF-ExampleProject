//
//  MovieRecommendationsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 06.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import SwiftUI

public struct RecommendationsContainer<F: RecommendationsFeature, R: Routing>: BindableContainer where R.Route == RecommendationsRoute {
    public typealias ContainerComponent = RecommendationsComponent<R>

    public let id: RecomendationTarget

    public func scope(for state: F) -> Scope {
        state.recommendationsBindableFlow[id]
        state.recommendationsBindableForm[id]
    }
    
    public init(id: RecomendationTarget) {
        self.id = id
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            title: "",
            items: items,
            genreById: store.state.allGenres.by(id:),
            loadMoreAction: loadNewPageIfNeeded,
            dialog: dialog,
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(
            ActionGroup {
                switch id {
                case let .movie(movieID):
                    Actions.SetPaginationItems(
                        items: store.state.allMovies.recommendationsByMovieId[movieID]?.elements ?? [],
                        id: RecommendationsFlow.id
                    )
                case let .show(showID):
                    Actions.SetPaginationItems(
                        items: store.state.allShows.recommendationsByShowId[showID]?.elements ?? [],
                        id: RecommendationsFlow.id
                    )
                }
                Actions.LoadPage(id: RecommendationsFlow.id)
            }.binded(to: self)
        )
    }
}

// MARK: - Props

private extension RecommendationsContainer {
    var form: RecommendationsForm {
        store.state.recommendationsBindableForm[id] ?? .init()
    }

    var flow: RecommendationsFlow {
        store.state.recommendationsBindableFlow[id] ?? .init()
    }
    
    var dialog: Binding<DialogStatus> {
        Binding {
            form.dialog
        } set: { newValue in
            store.dispatch(Actions.UpdateFormField(keyPath: \RecommendationsForm.dialog, value: newValue).binded(to: self))
        }

    }

    var items: [any Item] {
        switch id {
        case let .movie(movieID):
            let ids = store.state.allMovies.recommendationsByMovieId[movieID]?.elements ?? []
            return ids.map { store.state.allMovies.by(id: $0) }
        case let .show(showID):
            let ids = store.state.allShows.recommendationsByShowId[showID]?.elements ?? []
            return ids.map { store.state.allShows.by(id: $0) }
        }
        
    }

    func loadNewPageIfNeeded() {
        guard case .none = flow else {
            return
        }
        let currentPage = form.pageNumber(for: id)
        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: RecommendationsFlow.id
            ).binded(to: self)
        )
    }
}
