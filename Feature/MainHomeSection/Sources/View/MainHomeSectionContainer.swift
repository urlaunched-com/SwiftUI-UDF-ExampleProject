//
//  MainHomeSectionContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public struct MainHomeSectionContainer<F: MainHomeSectionFeature, S: Section, R: Routing>: Container where R.Route == MainHomeSectionRoute {
    public typealias ContainerComponent = MainHomeSectionComponent<S, R>

    public let section: S
    public let items: [any Item]

    public init(
        section: S,
        items: [any Item]
    ) {
        self.section = section
        self.items = items
    }

    public func scope(for state: F) -> Scope {
        state.allShows
        state.allMovies
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            section: section,
            items: items,
            genreById: store.state.allGenres.by(id:),
            router: R()
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadHomeSection(sectionId: section.id))
    }
}
