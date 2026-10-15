//
//  NetworkConnectivityMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 16.12.2022.
//

import Combine
import Foundation
import UDF

final class NetworkConnectivityMiddleware<F: NetworkConnectivityFeature>: Middleware<F>, @unchecked Sendable {
    var environment: NetworkConnectivityEnvironment!

    enum Cancellation {
        case networkMonitoring
    }

    required convenience init(store: some Store<F>, queue: DispatchQueue) {
        self.init(store: store, environment: Self.buildLiveEnvironment(for: store), queue: queue)
    }

    init(store: some Store<F>, environment: NetworkConnectivityEnvironment, queue: DispatchQueue) {
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
    static func buildLiveEnvironment(for _: some Store<F>) -> NetworkConnectivityEnvironment {
        F.NetworkConnectivityEnvironment.networkConnectivityEnvironment
    }

    static func buildTestEnvironment(for _: some Store) -> NetworkConnectivityEnvironment {
        .init(monitorNetwork: { _ in Just(true).eraseToAnyPublisher() })
    }
}

// MARK: - Effects

struct NetworkMonitoringEffect: Effectable {
    let queue: DispatchQueue
    let environment: NetworkConnectivityEnvironment

    var upstream: AnyPublisher<any Action, Never> {
        environment.monitorNetwork(queue)
            .map { satisfied in
                Actions.UpdateNetworkConnectivityStatus(satisfied: satisfied)
            }
            .eraseToAnyPublisher()
    }
}
