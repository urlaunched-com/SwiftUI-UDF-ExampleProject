//
//  SearchItemRemote.swift
//
//
//  Created by Oksana Fedorchuk on 26.05.2023.
//

import Foundation

public struct SearchItemRemote: Decodable {
    public var id: Int
    public var adult: Bool
    public var backdropPath: String?
    public var name: String?
    public var originalLanguage: String
    public var originalName: String?
    public var overview: String
    public var posterPath: String?
    public var mediaType: String
    public var genreIds: [Int]
    public var popularity: Double
    public var firstAirDate: String?
    public var voteAverage: Double
    public var voteCount: Int
    public var originCountry: [String]
    public var title, originalTitle, releaseDate: String?
    public var video: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case video
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        adult = container.decodeSafely(.adult) ?? false
        backdropPath = container.decodeSafely(.backdropPath)
        name = container.decodeSafely(.name)
        originalLanguage = container.decodeSafely(.originalLanguage) ?? ""
        originalName = container.decodeSafely(.originalName)
        overview = container.decodeSafely(.overview) ?? ""
        posterPath = container.decodeSafely(.posterPath)
        mediaType = container.decodeSafely(.mediaType) ?? ""
        genreIds = container.decodeSafely(.genreIds) ?? []
        popularity = container.decodeSafely(.popularity) ?? 0
        firstAirDate = container.decodeSafely(.firstAirDate)
        voteAverage = container.decodeSafely(.voteAverage) ?? 0
        voteCount = container.decodeSafely(.voteCount) ?? 0
        originCountry = container.decodeSafely(.originCountry) ?? []
        title = container.decodeSafely(.title)
        originalTitle = container.decodeSafely(.originalTitle)
        releaseDate = container.decodeSafely(.releaseDate)
        video = container.decodeSafely(.video) ?? false
    }
}
