//
//  URLSession.swift
//
//
//  Created by Alexander Sharko on 29.11.2022.
//

import Combine
import Foundation

extension URLSession {
    func validateDataTaskPublisher(request: URLRequest) -> AnyPublisher<Data, Error> {
        dataTaskPublisher(for: request)
            .tryMap { try validate($0.data, $0.response) }
            .eraseToAnyPublisher()
    }
}
