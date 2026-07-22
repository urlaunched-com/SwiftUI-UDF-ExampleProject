//
//  NetworkConnectivityMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 16.12.2022.
//

import Combine
import Common
import Foundation
import Network
import UDF

public final class NetworkConnectivityMiddleware<F: NetworkConnectivityFeature>: Middleware<F>, @unchecked Sendable {
    public var environment: Void!

    public enum Cancellation {
        case networkMonitoring
    }

    public required init(store: some Store<F>, queue: DispatchQueue) {
        super.init(store: store, queue: queue)

        run(NetworkMonitoringEffect(queue: queue), cancellation: Cancellation.networkMonitoring) { state, output in
            guard let networkStatusAction = output as? Actions.UpdateNetworkConnectivityStatus else {
                return false
            }

            if networkStatusAction.satisfied {
                if !state.networkConnectivityForm.satisfied {
                    return true
                }
            } else if state.networkConnectivityForm.satisfied {
                return true
            }

            return false
        }
    }
}

public struct NetworkMonitoringEffect: Effectable {
    public let queue: DispatchQueue

    public init(queue: DispatchQueue) {
        self.queue = queue
    }

    public var upstream: AnyPublisher<any Action, Never> {
        NWPathMonitor()
            .publisher(queue: queue)
            .map { status in
                Actions.UpdateNetworkConnectivityStatus(satisfied: status == .satisfied)
            }
            .eraseToAnyPublisher()
    }
}
