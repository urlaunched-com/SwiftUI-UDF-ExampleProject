//
//  NetworkConnectivity+Live.swift
//  Flick
//
//  Created by Maksym Horobets on 21.10.2026.
//  © 2026 You are launched
//

import Combine
import Common
import Network
import NetworkConnectivityModule

public extension NetworkConnectivityEnvironment {
    static var live: Self {
        .init(
            monitorNetwork: { queue in
                NWPathMonitor()
                    .publisher(queue: queue)
                    .map { $0 == .satisfied }
                    .eraseToAnyPublisher()
            }
        )
    }
}
