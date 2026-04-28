//
//  NetworkConnectivityMiddleware.swift
//  Flick
//
//  Created by Alexander Sharko on 16.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Combine
import Foundation
import Network
import UDF

final class NetworkConnectivityMiddleware: BaseMiddleware<AppState>, EnvironmentMiddleware {
    var environment: Void!

    enum Cancellation {
        case networkMonitoring
    }

    required init(store: some Store<AppState>, queue: DispatchQueue) {
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

struct NetworkMonitoringEffect: Effectable {
    var queue: DispatchQueue

    var upstream: AnyPublisher<any Action, Never> {
        NWPathMonitor()
            .publisher(queue: queue)
            .map { status in
                Actions.UpdateNetworkConnectivityStatus(satisfied: status == .satisfied)
            }
            .eraseToAnyPublisher()
    }
}
