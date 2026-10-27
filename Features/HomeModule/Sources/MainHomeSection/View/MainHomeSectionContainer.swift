//
//  MainHomeSectionContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

struct MainHomeSectionContainer<F: HomeFeature>: Container {
    typealias ContainerComponent = MainHomeSectionComponent<MainHomeSectionRouting<F>>

    let section: any Section
    let items: [any Item]

    init(
        section: any Section,
        items: [any Item]
    ) {
        self.section = section
        self.items = items
    }

    func scope(for state: F) -> Scope {
        state.allShows
        state.allMovies
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            section: section,
            items: items,
            genreById: store.state.allGenres.by(id:)
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadHomeSection(sectionId: section.id))
    }
}
