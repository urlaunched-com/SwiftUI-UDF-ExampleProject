//
//  BaseAPI.swift
//  Flick
//
//  Created by Alexander Sharko on 29.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import SwiftFoundation

let kBaseURLPath: String = "https://api.themoviedb.org/3"
public let kTMDBApiKey = ""
let kURLTimeoutInterval: TimeInterval = 10

let kRequestHeaders: [String: String] = [
    "Content-Type": "application/json",
    "cache-control": "no-cache",
]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
}

public enum APIError: LocalizedError {
    case invalidBody
    case emptyData
    case invalidJSON
    case invalidResponse
    case statusCode(Int, Error)

    public var statusCode: Int? {
        if case let .statusCode(code, _) = self {
            return code
        }

        return 0
    }
}

enum URLEndpoint: RawRepresentable {
    typealias RawValue = String
    case requestToken
    case validateToken(apiKey: String)
    case session(apiKey: String)
    case guestSession
    case movieGenres
    case showGenres
    case movies(section: String)
    case shows(section: String)
    case movie(id: Int)
    case show(id: Int)
    case configuration
    case movieCast(id: Int)
    case showCast(id: Int)
    case movieReviews(id: Int)
    case showReviews(id: Int)
    case movieRecommendations(id: Int)
    case showRecommendations(id: Int)
    case multiSearch
    case custom(urlPath: String)

    init?(rawValue _: RawValue) {
        fatalError()
    }

    var rawValue: String {
        switch self {
        case .requestToken:
            return "/authentication/token/new"
        case let .validateToken(apiKey):
            return "/authentication/token/validate_with_login?api_key=\(apiKey)"
        case let .session(apiKey):
            return "/authentication/session?api_key=\(apiKey)"
        case .guestSession:
            return "/authentication/guest_session/new"
        case .movieGenres:
            return "/genre/movie/list"
        case .showGenres:
            return "/genre/tv/list"
        case let .movies(section):
            return "/movie/\(section)"
        case let .shows(section):
            return "/tv/\(section)"
        case let .movie(id):
            return "/movie/\(id)"
        case let .show(id):
            return "/tv/\(id)"
        case .configuration:
            return "/configuration"
        case let .movieCast(id):
            return "/movie/\(id)/credits"
        case let .showCast(id):
            return "/tv/\(id)/credits"
        case let .movieReviews(id):
            return "/movie/\(id)/reviews"
        case let .showReviews(id):
            return "/tv/\(id)/reviews"
        case let .movieRecommendations(id):
            return "/movie/\(id)/recommendations"
        case let .showRecommendations(id):
            return "/tv/\(id)/recommendations"
        case .multiSearch:
            return "/search/multi"
        case let .custom(urlPath):
            return urlPath
        }
    }
}

enum URLParameter: String {
    case currentDatetime = "current_datetime"
    case username
    case password
    case requestToken = "request_token"
    case apiKey = "api_key"
    case page
    case query
}

@discardableResult
func validate(_ data: Data, _ response: URLResponse) throws -> Data {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponse
    }
    guard (200 ..< 300).contains(httpResponse.statusCode) else {
        throw APIError.statusCode(httpResponse.statusCode, ServerError(data: data, response: httpResponse) ?? SomeError())
    }
    return data
}

func encode(_ params: [String: Any?], for httpMethod: HTTPMethod) -> Data? {
    switch httpMethod {
    case .get:
        return params.percentEscaped().data(using: .utf8)

    default:
        return try? JSONSerialization.data(withJSONObject: params)
    }
}
