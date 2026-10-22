//
//  SessionResponse.swift
//
//
//  Created by Alexander Sharko on 29.11.2022.
//

import Foundation

public struct SessionResponse: Decodable {
    public var success: Bool
    public var sessionId: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = container.decodeSafely(.success) ?? false
        sessionId = container.decodeSafely(.sessionId) ?? ""
    }
}
