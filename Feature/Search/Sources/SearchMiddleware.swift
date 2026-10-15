//
//  SearchMiddleware.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
@preconcurrency import SearchModels

enum Cancellation: Hashable {
    case loadItems
}

final class SearchMiddleware<F: SearchFeature>: Middleware<F>, @unchecked Sendable {
    var environment: SearchEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.searchFeatureState.searchFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        switch state.searchFeatureState.searchFlow {
        case let .loadItems(page):
            execute(flowId: SearchFlow.id, cancellation: Cancellation.loadItems) { [unowned self] taskId in
                let items = try await self.environment.loadItems(state.searchFeatureState.searchForm.searchText, page)
                return Actions.DidLoadItems(items: items, id: taskId)
            }

        default:
            break
        }
    }
}

// MARK: - Environment build methods

extension SearchMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> SearchEnvironment {
        F.SearchEnvironment.searchEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> SearchEnvironment {
        SearchEnvironment(
            loadItems: { _, _ in SearchItem.fakeItems() }
        )
    }
}
