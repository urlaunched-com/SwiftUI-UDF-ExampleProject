//
//  MovieRemote.swift
//
//
//  Created by Alexander Sharko on 01.12.2022.
//

import Foundation

public struct MovieRemote: Decodable {
    public var id: Int
    public var posterPath: String?
    public var adult: Bool
    public var overview: String
    public var releaseDate: String
    public var genreIds: [Int]
    public var originalTitle: String
    public var originalLanguage: String
    public var title: String
    public var backdropPath: String?
    public var popularity: Double
    public var voteCount: Int
    public var video: Bool
    public var voteAverage: Double
    public var revenue: Int
    public var budget: Int
    public var status: String
    public var runtime: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case revenue
        case budget
        case status
        case runtime
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        posterPath = container.decodeSafely(.posterPath)
        adult = container.decodeSafely(.adult) ?? false
        overview = container.decodeSafely(.overview) ?? ""
        releaseDate = container.decodeSafely(.releaseDate) ?? ""
        genreIds = container.decodeSafely(.genreIds) ?? []
        originalTitle = container.decodeSafely(.originalTitle) ?? ""
        originalLanguage = container.decodeSafely(.originalLanguage) ?? ""
        title = container.decodeSafely(.title) ?? ""
        backdropPath = container.decodeSafely(.backdropPath)
        popularity = container.decodeSafely(.popularity) ?? 0
        voteCount = container.decodeSafely(.voteCount) ?? 0
        video = container.decodeSafely(.video) ?? false
        voteAverage = container.decodeSafely(.voteAverage) ?? 0
        revenue = container.decodeSafely(.revenue) ?? 0
        budget = container.decodeSafely(.budget) ?? 0
        status = container.decodeSafely(.status) ?? ""
        runtime = container.decodeSafely(.runtime)
    }
}
