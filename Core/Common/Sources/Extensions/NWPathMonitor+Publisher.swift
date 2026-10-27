//
//  NWPathMonitor+Publisher.swift
//  Flick
//
//  Created by Max Kuznetsov on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Combine
import Foundation
import Network

public extension NWPathMonitor {
    final class NetworkStatusSubscription<S: Subscriber>: Subscription where S.Input == NWPath.Status {
        private let subscriber: S?
        private let monitor: NWPathMonitor
        private let queue: DispatchQueue

        public init(
            subscriber: S,
            monitor: NWPathMonitor,
            queue: DispatchQueue
        ) {
            self.subscriber = subscriber
            self.monitor = monitor
            self.queue = queue
        }

        public func request(_: Subscribers.Demand) {
            monitor.pathUpdateHandler = { [weak self] path in
                _ = self?.subscriber?.receive(path.status)
            }

            monitor.start(queue: queue)
        }

        public func cancel() {
            monitor.cancel()
        }
    }
}

// MARK: - NWPathMonitor Publisher

public extension NWPathMonitor {
    struct NetworkStatusPublisher: Publisher {
        public typealias Output = NWPath.Status
        public typealias Failure = Never

        private let monitor: NWPathMonitor
        private let queue: DispatchQueue

        init(monitor: NWPathMonitor, queue: DispatchQueue) {
            self.monitor = monitor
            self.queue = queue
        }

        public func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, NWPath.Status == S.Input {
            let subscription = NetworkStatusSubscription(
                subscriber: subscriber,
                monitor: monitor,
                queue: queue
            )

            subscriber.receive(subscription: subscription)
        }
    }

    func publisher(queue: DispatchQueue) -> NWPathMonitor.NetworkStatusPublisher {
        NetworkStatusPublisher(monitor: self, queue: queue)
    }
}
