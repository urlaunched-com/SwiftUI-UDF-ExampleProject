//
//  ImageConfigsMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
@preconcurrency import ImageModels

final class ImageConfigsMiddleware<F: ImageFeature>: Middleware<F>, @unchecked Sendable {
    var environment: ImageEnvironment!

    func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.imageFeatureState.imageConfigsFlow
    }

    override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    func observe(state: F) {
        switch state.imageFeatureState.imageConfigsFlow {
        case .loading:
            execute(
                flowId: ImageConfigsFlow.id,
                cancellation: Cancellation.loadImageConfigs
            ) { [unowned self] taskId in
                let imageConfigs = try await self.environment.loadImageConfigs()
                return ActionGroup {
                    Actions.DidLoadItem(item: imageConfigs, id: taskId)
                    if state.imageFeatureState.imageConfigsForm.configs != imageConfigs {
                        Actions.Message(message: "New configs for images", id: taskId)
                    }
                }
            }

        default:
            break
        }
    }

    enum Cancellation: Hashable {
        case loadImageConfigs
    }
}

// MARK: - Environment build methods

extension ImageConfigsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> ImageEnvironment {
        F.ImageEnvironment.imageEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> ImageEnvironment {
        ImageEnvironment(
            loadImageConfigs: { .testItem() }
        )
    }
}
