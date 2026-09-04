//
//  ImageConfigsRemote.swift
//
//
//  Created by Alexander Sharko on 03.01.2023.
//

import Foundation

public struct ImageConfigsRemote: Decodable {
    public var baseUrl: String
    public var secureBaseUrl: String
    public var backdropSizes: [String]
    public var logoSizes: [String]
    public var posterSizes: [String]
    public var profileSizes: [String]
    public var stillSizes: [String]

    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseUrl = container.decodeSafely(.baseUrl) ?? ""
        secureBaseUrl = container.decodeSafely(.secureBaseUrl) ?? ""
        backdropSizes = container.decodeSafely(.backdropSizes) ?? []
        logoSizes = container.decodeSafely(.logoSizes) ?? []
        posterSizes = container.decodeSafely(.posterSizes) ?? []
        profileSizes = container.decodeSafely(.profileSizes) ?? []
        stillSizes = container.decodeSafely(.stillSizes) ?? []
    }
}
