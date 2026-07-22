//
//  HomeSectionContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 30.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models
import Common
import HomeSectionComponent
import Image

struct HomeSectionContainer<S: Models.Section>: Container {
    typealias ContainerComponent = HomeSectionComponent<S, HomeSectionRouter>

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
            genreById: { store.state.allGenres.byId[$0] },
            destinationBuilder: DestinationBuilder<HomeContent>(destination: { value in
                switch value {
                case let .imageContainer(path: path, size: size, type: type):
                    ImageContainer<AppState>(size: size, path: path, type: type)
                }
            })
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadHomeSection(sectionId: section.id))
    }
}
