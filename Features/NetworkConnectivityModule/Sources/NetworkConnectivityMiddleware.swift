//
//  NetworkConnectivityMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 16.12.2022.
//

import Combine
import Foundation
import UDF
import Models

final class NetworkConnectivityMiddleware<F: NetworkConnectivityFeature>: Middleware<F>, @unchecked Sendable {
    public typealias Environment = NetworkConnectivityEnvironment
    public var environment: Environment!

    public enum Cancellation {
        case networkMonitoring
    }

    public required convenience init(store: some Store<F>, queue: DispatchQueue) {
        self.init(store: store, environment: Self.buildLiveEnvironment(for: store), queue: queue)
    }

    public init(store: some Store<F>, environment: Environment, queue: DispatchQueue) {
        self.environment = environment
        super.init(store: store, queue: queue)

        run(NetworkMonitoringEffect(queue: queue, environment: environment), cancellation: Cancellation.networkMonitoring) { state, output in
            guard let networkStatusAction = output as? Actions.UpdateNetworkConnectivityStatus else {
                return false
            }

            if networkStatusAction.satisfied {
                if !state.networkConnectivityFeatureState.networkConnectivityForm.satisfied {
                    return true
                }
            } else if state.networkConnectivityFeatureState.networkConnectivityForm.satisfied {
                return true
            }

            return false
        }
    }
}

// MARK: - Environment build methods

extension NetworkConnectivityMiddleware {
    static func buildLiveEnvironment(for _: some Store<F>) -> Environment {
        F.Environments.networkConnectivity
    }

    static func buildTestEnvironment(for _: some Store) -> Environment {
        Environment(
            monitorNetwork: { _ in Just(true).eraseToAnyPublisher() }
        )
    }
}

// MARK: - Effects

public struct NetworkMonitoringEffect: Effectable {
    public let queue: DispatchQueue
    public let environment: NetworkConnectivityEnvironment

    public init(queue: DispatchQueue, environment: NetworkConnectivityEnvironment) {
        self.queue = queue
        self.environment = environment
    }

    public var upstream: AnyPublisher<any Action, Never> {
        environment.monitorNetwork(queue)
            .map { satisfied in
                Actions.UpdateNetworkConnectivityStatus(satisfied: satisfied)
            }
            .eraseToAnyPublisher()
    }
}
