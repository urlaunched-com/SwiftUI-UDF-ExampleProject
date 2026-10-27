//
//  AuthAPIClient.swift
//
//
//  Created by Alexander Sharko on 29.11.2022.
//

import Foundation

public enum AuthAPIClient {
    public static func requestToken(apiKey: String) async throws -> RequestTokenResponse {
        let request = URLRequest.request(for: .requestToken) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: apiKey)
        }
        return try await request.loadValidResult(type: RequestTokenResponse.self)
    }

    public static func validateToken(apiKey: String, username: String, password: String, requestToken: String) async throws {
        var request = URLRequest.request(for: .validateToken(apiKey: apiKey), httpMethod: .post)
        let parameters: [String: Any] = [
            URLParameter.username.rawValue: username,
            URLParameter.password.rawValue: password,
            URLParameter.requestToken.rawValue: requestToken,
        ]
        request.httpBody = encode(parameters, for: .post)
        try await request.loadValidResult()
    }

    public static func createSession(apiKey: String, requestToken: String) async throws -> SessionResponse {
        var request = URLRequest.request(for: .session(apiKey: apiKey), httpMethod: .post)
        let parameters: [String: Any] = [URLParameter.requestToken.rawValue: requestToken]
        request.httpBody = encode(parameters, for: .post)
        return try await request.loadValidResult(type: SessionResponse.self)
    }

    public static func createGuestSession(apiKey: String) async throws -> GuestSessionResponse {
        let request = URLRequest.request(for: .guestSession) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: apiKey)
        }
        return try await request.loadValidResult(type: GuestSessionResponse.self)
    }
}
