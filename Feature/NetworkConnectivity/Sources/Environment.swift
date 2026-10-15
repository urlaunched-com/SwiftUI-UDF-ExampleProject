//
//  Environment.swift
//  Flick
//
//  Created by Bogdan Petkanych on 15.10.26.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Combine
import Foundation

public protocol NetworkConnectivityEnvironmentProviding {
    static var networkConnectivityEnvironment: NetworkConnectivityEnvironment { get }
}

public struct NetworkConnectivityEnvironment: Sendable {
    var monitorNetwork: @Sendable (_ queue: DispatchQueue) -> AnyPublisher<Bool, Never>

    public init(monitorNetwork: @Sendable @escaping (_ queue: DispatchQueue) -> AnyPublisher<Bool, Never>) {
        self.monitorNetwork = monitorNetwork
    }
}
