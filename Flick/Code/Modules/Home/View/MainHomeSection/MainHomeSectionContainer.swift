//
//  MainHomeSectionContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import UDF

struct MainHomeSectionContainer<S: Section>: Container {
    typealias ContainerComponent = MainHomeSectionComponent<S>

    let section: S
    var retrieveItems: () -> [any Item]
    var scopeOfWork: (_ state: AppState) -> Scope

    init(
        section: S,
        retrieveItems: @escaping () -> [any Item],
        @ScopeBuilder scopeOfWork: @escaping (_ state: AppState) -> Scope
    ) {
        self.section = section
        self.retrieveItems = retrieveItems
        self.scopeOfWork = scopeOfWork
    }

    func scope(for state: AppState) -> Scope {
        return scopeOfWork(state)
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
