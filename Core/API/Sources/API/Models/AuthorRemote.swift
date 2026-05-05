//
//  AuthorRemote.swift
//
//
//  Created by Alexander Sharko on 07.02.2023.
//

import Foundation

public struct AuthorRemote: Decodable {
    public var name: String
    public var username: String
    public var avatarPath: String?
    public var rating: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = container.decodeSafely(.name) ?? ""
        username = container.decodeSafely(.username) ?? ""
        avatarPath = container.decodeSafely(.avatarPath)
        rating = container.decodeSafely(.rating)
    }
}
