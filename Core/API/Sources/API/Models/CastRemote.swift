//
//  CastRemote.swift
//
//
//  Created by Alexander Sharko on 19.01.2023.
//

import Foundation

public struct CastRemote: Decodable {
    public var id: Int
    public var name: String
    public var character: String
    public var profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        name = try container.decode(.name)
        character = try container.decode(.character)
        profilePath = container.decodeSafely(.profilePath)
    }
}
