//
//  ShowDetailsRecommendationsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 05.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import Common
import ItemDetailsRecommendationsComponent
import Image

struct ShowDetailsRecommendationsContainer: BindableContainer {
    typealias ContainerComponent = ItemDetailsRecommendationsComponent<ItemDetailsRecommendationsRouting>

    let id: Show.ID

    func scope(for state: AppState) -> Scope {
        state.showDetailsRecommendationsFlow[id]
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            item: store.state.allShows.showBy(id: id),
            items: isRedacted ? Show.fakeItems(count: 3) : shows,
            isRedacted: isRedacted,
            genreById: store.state.allGenres.genreBy,
            destinationBuilder: DestinationBuilder<ItemDetailsRecommendationsContent>(destination: { value in
                switch value {
                case let .imageContainer(path: path, size: size, type: type):
                    ImageContainer<AppState>(size: size, path: path, type: type)
                }
            })
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPage(id: ShowRecommendationsFlow.id).binded(to: self))
    }
}

// MARK: - Props

private extension ShowDetailsRecommendationsContainer {
    var flow: ShowRecommendationsFlow {
        store.state.showDetailsRecommendationsFlow[id] ?? .init()
    }

    var shows: [Show] {
        let ids = store.state.allShows.recommendationsByShowId[id]?.elements ?? []
        return ids.map { store.state.allShows.showBy(id: $0) }
    }

    var isRedacted: Bool {
        if case .loadShows = flow, shows.isEmpty {
            return true
        }
        return false
    }
}
