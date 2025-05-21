//
//  SearchContainer.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct SearchContainer: Container {
    typealias ContainerComponent = SearchComponent

    func scope(for state: AppState) -> Scope {
        state.searchForm
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            searchText: Binding(store.$state.searchForm.searchText).didSet { _, _ in
                store.dispatch(Actions.LoadPage(id: SearchFlow.id))
            },
            itemIds: store.state.searchForm.items,
            searchItemById: store.state.allSearchItems.searchItemBy,
            genreById: { _ in .testItem() },
            loadMoreAction: loadNewPageIfNeeded
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPage(id: SearchFlow.id))
    }
}

// MARK: - Props

private extension SearchContainer {
    func loadNewPageIfNeeded() {
        guard case let .number(currentPage) = store.state.searchForm.page,
              case .none = store.state.searchFlow else { return }

        store.dispatch(
            Actions.LoadPage(
                pageNumber: currentPage + 1,
                id: SearchFlow.id
            )
        )
    }
}
