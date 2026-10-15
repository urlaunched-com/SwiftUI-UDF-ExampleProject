//
//  AppEnvironments+NetworkConnectivity.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import NetworkConnectivity
import Common
import Combine
import Network

extension AppEnvironments: NetworkConnectivityEnvironmentProviding {
    static var networkConnectivityEnvironment: NetworkConnectivityEnvironment {
        NetworkConnectivityEnvironment(
            monitorNetwork: { queue in
                NWPathMonitor()
                    .publisher(queue: queue)
                    .map { $0 == .satisfied }
                    .eraseToAnyPublisher()
            }
        )
    }
}
