//
//  ImageConfigsMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import UDF

final class ImageConfigsMiddleware: BaseObservableMiddleware<AppState> {
    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.networkConnectivityForm
        state.imageConfigsFlow
    }

    override func status(for state: AppState) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: AppState) {
        switch state.imageConfigsFlow {
        case .loading:
            execute(flowId: ImageConfigsFlow.id, cancellation: Cancellation.loadImageConfigs) { [unowned self] taskId in
                let imageConfigs = try await self.environment.loadImageConfigs()
                return ActionGroup {
                    Actions.DidLoadItem(item: imageConfigs, id: taskId)
                    if state.imageConfigsForm.configs != imageConfigs {
                        Actions.Message(message: "New configs for images", id: taskId)
                    }
                }
            }

        default:
            break
        }
    }

    struct Environment {
        var loadImageConfigs: () async throws -> ImageConfigs
    }

    enum Cancellation: Hashable {
        case loadImageConfigs
    }
}

// MARK: - Environment buid methods

extension ImageConfigsMiddleware {
    static func buildLiveEnvironment(for _: some Store) -> Environment {
        Environment(
            loadImageConfigs: {
                try await ImageConfigsAPIClient.loadConfigs().asImageConfigs
            }
        )
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadImageConfigs: { .testItem() }
        )
    }
}
