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
@preconcurrency import Models

enum Cancellation: Hashable {
    case loadItems
}

public final class SearchMiddleware<F: SearchFeature>: Middleware<F>, @unchecked Sendable {
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.searchFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
        switch state.searchFlow {
        case let .loadItems(page):
            execute(flowId: SearchFlow.id, cancellation: Cancellation.loadItems) { [unowned self] taskId in
                print("execute task insside SearchMiddleware")
                let items = try await self.environment.loadItems(state.searchForm.searchText, page)
                return Actions.DidLoadItems(items: items, id: taskId)
            }

        default:
            break
        }
    }

    public struct Environment {
        var loadItems: (_ query: String, _ page: Int) async throws -> [SearchItem]
    }
}

// MARK: - Environment buid methods

public extension SearchMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
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
