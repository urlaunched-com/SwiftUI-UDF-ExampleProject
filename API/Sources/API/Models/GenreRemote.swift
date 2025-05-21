//
//  GenreRemote.swift
//
//
//  Created by Alexander Sharko on 05.12.2022.
//

import Foundation

public struct GenreRemote: Decodable {
    public var id: Int
    public var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        name = container.decodeSafely(.name) ?? ""
    }
}
