//
//  HomeSectionContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF
import SectionsModels
import MediaModels
import Models

struct HomeSectionContainer<F: HomeSectionFeature>: Container {
    typealias ContainerComponent = HomeSectionComponent<F.HomeSectionFeatureRouting>

    let section: any SectionsModels.Section
    let items: [any Item]

    init(
        section: any SectionsModels.Section,
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
            genreById: store.state.allGenres.by(id:),
            router: .init(routing: F.HomeSectionFeatureRouting())
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadHomeSection(sectionId: section.id))
    }
}
