//
//  MainHomeSectionContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import UDF
import Models

struct MainHomeSectionContainer<S: Section>: Container {
    typealias ContainerComponent = MainHomeSectionComponent<S>

    let section: S
    var retrieveItems: () -> [any Item]

    init(
        section: S,
        retrieveItems: @escaping () -> [any Item]
    ) {
        self.section = section
        self.retrieveItems = retrieveItems
    }

    func scope(for state: AppState) -> Scope {
        state.allShows
        state.allMovies
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            section: section,
            items: retrieveItems(),
            genreById: { store.state.allGenres.byId[$0] }
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadHomeSection(sectionId: section.id))
    }
}
