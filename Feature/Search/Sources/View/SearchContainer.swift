//
//  SearchContainer.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Common

public struct SearchContainer<F: SearchFeature, R: Routing>: Container where R.Route == SearchRoute {
    public typealias ContainerComponent = SearchComponent<R>

    public func scope(for state: F) -> Scope {
        state.searchForm
    }
    
    public init() {}

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            searchText: store.$state.searchForm.searchText.didSet { _, _ in
                store.dispatch(Actions.LoadPage(id: SearchFlow.id))
            },
            itemIds: store.state.searchForm.items,
            searchItemById: store.state.allSearchItems.by(id:),
            genreById: { _ in .testItem() },
            loadMoreAction: loadNewPageIfNeeded,
            router: R()
        )
    }

    public func onContainerDidLoad(store: EnvironmentStore<F>) {
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
