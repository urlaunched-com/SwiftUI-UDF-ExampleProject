//
//  MainHomeSectionContainer.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import struct SwiftUI.Environment
import UDF
import Models

struct MainHomeSectionContainer<F: HomeFeature>: Container {
    typealias ContainerComponent = MainHomeSectionComponent<MainHomeSectionRouting<F>>

    let section: any Section
    let items: [any Item]

    @Environment(\.globalRouter) private var globalRouter

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
            genreById: store.state.allGenres.by(id:),
            router: .init(routing: MainHomeSectionRouting<F>()),
            seeAllAction: {
                if let link = HomeLink(section: section) {
                    globalRouter.navigate(for: HomeLinkRouting<F>.self, to: link)
                }
            }
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadHomeSection(sectionId: section.id))
    }
}
