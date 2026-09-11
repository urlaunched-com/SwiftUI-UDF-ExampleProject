//
//  MainHomeSectionContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public struct MainHomeSectionContainer<F: MainHomeSectionFeature>: Container {
    public typealias ContainerComponent = MainHomeSectionComponent<F.MainHomeSectionFeatureRouting>

    public let section: any Section
    public let items: [any Item]

    public init(
        section: any Section,
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
            router: .init(routing: F.MainHomeSectionFeatureRouting())
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadHomeSection(sectionId: section.id))
    }
}
