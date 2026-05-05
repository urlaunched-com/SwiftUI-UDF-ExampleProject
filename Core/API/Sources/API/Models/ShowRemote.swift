//
//  ShowRemote.swift
//
//
//  Created by Alexander Sharko on 01.12.2022.
//

import Foundation

public struct ShowRemote: Decodable {
    public var id: Int
    public var posterPath: String
    public var popularity: Double
    public var backdropPath: String
    public var voteAverage: Double
    public var overview: String
    public var firstAirDate: String
    public var originCountry: [String]
    public var genreIds: [Int]
    public var originalLanguage: String
    public var voteCount: Int
    public var name: String
    public var originalName: String
    public var episodeRunTime: [Int]
    public var status: String
    public var networks: [NetworkRemote]
    public var type: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case popularity
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case episodeRunTime = "episode_run_time"
        case status
        case networks
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        posterPath = container.decodeSafely(.posterPath) ?? ""
        popularity = container.decodeSafely(.popularity) ?? 0
        backdropPath = container.decodeSafely(.backdropPath) ?? ""
        voteAverage = container.decodeSafely(.voteAverage) ?? 0
        overview = container.decodeSafely(.overview) ?? ""
        firstAirDate = container.decodeSafely(.firstAirDate) ?? ""
        originCountry = container.decodeSafely(.originCountry) ?? []
        genreIds = container.decodeSafely(.genreIds) ?? []
        originalLanguage = container.decodeSafely(.originalLanguage) ?? ""
        voteCount = container.decodeSafely(.voteCount) ?? 0
        name = container.decodeSafely(.name) ?? ""
        originalName = container.decodeSafely(.originalName) ?? ""
        episodeRunTime = container.decodeSafely(.episodeRunTime) ?? []
        status = container.decodeSafely(.status) ?? ""
        networks = container.decodeSafely(.networks) ?? []
        type = container.decodeSafely(.type) ?? ""
    }
}
