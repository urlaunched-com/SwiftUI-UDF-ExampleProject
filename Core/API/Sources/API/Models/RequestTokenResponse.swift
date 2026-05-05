//
//  RequestTokenResponse.swift
//
//
//  Created by Alexander Sharko on 29.11.2022.
//

import Foundation

public struct RequestTokenResponse: Decodable {
    public var success: Bool
    public var expiresAt: String
    public var requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = container.decodeSafely(.success) ?? false
        expiresAt = container.decodeSafely(.expiresAt) ?? ""
        requestToken = container.decodeSafely(.requestToken) ?? ""
    }
}
