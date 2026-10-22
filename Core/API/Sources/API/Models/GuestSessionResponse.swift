//
//  GuestSessionResponse.swift
//
//
//  Created by Alexander Sharko on 29.11.2022.
//

import Foundation

public struct GuestSessionResponse: Decodable {
    public var success: Bool
    public var guestSessionId: String
    public var expiresAt: String

    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionId = "guest_session_id"
        case expiresAt = "expires_at"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = container.decodeSafely(.success) ?? false
        guestSessionId = try container.decode(.guestSessionId)
        expiresAt = try container.decode(.expiresAt)
    }
}
