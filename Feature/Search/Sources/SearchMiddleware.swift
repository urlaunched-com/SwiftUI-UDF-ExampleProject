//
//  SearchMiddleware.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
@preconcurrency import Models

public struct SearchEnvironment {
    public var loadItems: (_ query: String, _ page: Int) async throws -> [SearchItem]

    public init(
        loadItems: @escaping (_ query: String, _ page: Int) async throws -> [SearchItem]
    ) {
        self.loadItems = loadItems
    }
}

enum Cancellation: Hashable {
    case loadItems
}

final class SearchMiddleware<F: SearchFeature>: Middleware<F>, @unchecked Sendable {
    public typealias Environment = SearchEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.searchFeatureState.searchFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
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

// MARK: - Environment buid methods

extension SearchMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.search
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadItems: { _, _ in SearchItem.fakeItems() }
        )
    }
}
