//
//  Environment.swift
//  Flick
//
//  Created by Maksym Horobets on 21.10.2026.
//  © 2026 You are launched
//

import Combine
import Foundation

/// The live environment the Network Connectivity flow's middleware needs. The host supplies it, so the flow
/// never depends on the framework that monitors the network.
public protocol NetworkConnectivityEnvironmentProviding {
    static var networkConnectivity: NetworkConnectivityEnvironment { get }
}

public struct NetworkConnectivityEnvironment: Sendable {
    public var monitorNetwork: @Sendable (_ queue: DispatchQueue) -> AnyPublisher<Bool, Never>

    public init(
        monitorNetwork: @escaping @Sendable (_ queue: DispatchQueue) -> AnyPublisher<Bool, Never>
    ) {
        self.monitorNetwork = monitorNetwork
    }
}
