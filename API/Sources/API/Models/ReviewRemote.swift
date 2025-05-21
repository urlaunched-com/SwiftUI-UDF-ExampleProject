//
//  ReviewRemote.swift
//
//
//  Created by Alexander Sharko on 07.02.2023.
//

import Foundation

public struct ReviewRemote: Decodable {
    public var id: String
    public var author: String
    public var authorDetails: AuthorRemote
    public var content: String

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case authorDetails = "author_details"
        case content
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        author = container.decodeSafely(.author) ?? ""
        authorDetails = try container.decode(.authorDetails)
        content = container.decodeSafely(.content) ?? ""
    }
}
