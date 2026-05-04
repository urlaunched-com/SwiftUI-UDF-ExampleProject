//
//  SearchMiddleware.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import UDF

final class SearchMiddleware: BaseObservableMiddleware<AppState> {
    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.searchFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        switch state.searchFlow {
        case let .loadItems(page):
            execute(flowId: SearchFlow.id, cancellation: Cancellation.loadItems) { [unowned self] taskId in
                let items = try await self.environment.loadItems(state.searchForm.searchText, page)
                return Actions.DidLoadItems(items: items, id: taskId)
            }

        default:
            break
        }
    }

    struct Environment {
        var loadItems: (_ query: String, _ page: Int) async throws -> [SearchItem]
    }

    enum Cancellation: Hashable {
        case loadItems
    }
}

// MARK: - Environment buid methods

extension SearchMiddleware {
    static func buildLiveEnvironment(for _: some Store<AppState>) -> Environment {
        Environment(
            loadItems: { query, page in
                try await SearchAPIClient.loadSearchItems(query: query, page: page)
                    .map(\.asSearchItem)
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadItems: { _, _ in SearchItem.fakeItems() }
        )
    }
}
