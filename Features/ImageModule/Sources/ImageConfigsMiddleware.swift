//
//  ImageConfigsMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import Models

public struct ImageConfigsEnvironment {
    public var loadImageConfigs: () async throws -> ImageConfigs

    public init(
        loadImageConfigs: @escaping () async throws -> ImageConfigs
    ) {
        self.loadImageConfigs = loadImageConfigs
    }
}

final class ImageConfigsMiddleware<F: ImageFeature>: Middleware<F>, @unchecked Sendable {
    public typealias Environment = ImageConfigsEnvironment
    public var environment: Environment!

    public func scope(for state: F) -> Scope {
        state.networkConnectivityForm
        state.imageFeatureState.imageConfigsFlow
    }

    public override func status(for state: F) -> MiddlewareStatus {
        state.networkConnectivityForm.satisfied ? .active : .suspend
    }

    public func observe(state: F) {
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

    public enum Cancellation: Hashable {
        case loadImageConfigs
    }
}

extension ImageConfigsMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.imageConfigs
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            loadImageConfigs: { .testItem() }
        )
    }
}
