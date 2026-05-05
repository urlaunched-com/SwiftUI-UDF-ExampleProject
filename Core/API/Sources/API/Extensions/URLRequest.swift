//
//  URLRequest.swift
//
//
//  Created by Alexander Sharko on 29.11.2022.
//

import Foundation

extension URLRequest {
    static func request(
        for endpoint: URLEndpoint,
        httpMethod: HTTPMethod = .get,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeoutInterval: TimeInterval = kURLTimeoutInterval,
        @URLQueryItemBuilder queryItems: () -> [URLQueryItem] = { [] }
    ) -> URLRequest {
        guard let string = (kBaseURLPath + endpoint.rawValue).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              var components = URLComponents(string: string)
        else {
            fatalError("url can't be nil")
        }

        if case let .custom(customUrlPath) = endpoint, let customComponents = URLComponents(string: customUrlPath) {
            components = customComponents
        }

        let queryItems = queryItems()
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            fatalError("url can't be nil")
        }

        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = kRequestHeaders
        request.allHTTPHeaderFields?[URLParameter.currentDatetime.rawValue.lowercased()] = customIso8601.string(from: Date())
        return request
    }

    static func request(
        for endpoint: URLEndpoint,
        httpMethod: HTTPMethod = .get,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeoutInterval: TimeInterval = kURLTimeoutInterval,
        queryDict: [String: String?]
    ) -> URLRequest {
        let queryItems = queryDict.map { (key: String, value: String?) in
            URLQueryItem(name: key, value: value)
        }

        return request(
            for: endpoint,
            httpMethod: httpMethod,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval,
            queryItems: { queryItems }
        )
    }
}

private extension URLRequest {
    static var customIso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+0000"
        return formatter
    }()
}

extension URLRequest {
    @resultBuilder
    struct URLQueryItemBuilder {
        static func buildBlock(_ components: [URLQueryItem]...) -> [URLQueryItem] {
            components.flatMap { $0 }
        }

        static func buildExpression(_ components: URLQueryItem) -> [URLQueryItem] {
            [components]
        }

        static func buildExpression(_ components: [URLQueryItem]) -> [URLQueryItem] {
            components
        }

        static func buildOptional(_ components: [URLQueryItem]?) -> [URLQueryItem] {
            components ?? []
        }
    }
}
