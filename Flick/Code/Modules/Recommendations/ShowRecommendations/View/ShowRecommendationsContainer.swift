//
//  ShowRecommendationsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 06.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF

struct ShowRecommendationsContainer: BindableContainer {
    typealias ContainerComponent = SectionDetailsComponent

    let id: Show.ID

    func scope(for state: AppState) -> Scope {
        state.showRecommendationsFlow[id]
        state.showRecommendationsForm[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            title: "",
            items: shows,
            genreById: store.state.allGenres.genreBy,
            loadMoreAction: loadNewPageIfNeeded,
            alertStatus: store.$state.showRecommendationsForm[id].alert
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(
            ActionGroup {
                Actions.SetPaginationItems(
                    items: store.state.allShows.recommendationsByShowId[id]?.elements ?? [],
                    id: ShowRecommendationsFlow.id
                )
                Actions.LoadPage(id: ShowRecommendationsFlow.id)
            }.binded(to: self)
        )
    }
}

// MARK: - Props

private extension ShowRecommendationsContainer {
    var form: ShowRecommendationsForm {
        store.state.showRecommendationsForm[id] ?? .init()
    }

    var flow: ShowRecommendationsFlow {
        store.state.showRecommendationsFlow[id] ?? .init()
    }

    var shows: [Show] {
        let ids = store.state.allShows.recommendationsByShowId[id]?.elements ?? []
        return ids.map { store.state.allShows.showBy(id: $0) }
    }

    func loadNewPageIfNeeded() {
        guard case let .number(currentPage) = form.page, case .none = flow else { return }

        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: ShowRecommendationsFlow.id
            ).binded(to: self)
        )
    }
}
