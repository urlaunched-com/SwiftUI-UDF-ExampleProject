//
//  SearchItem.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 26.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation
import UDF
import Common

public struct SearchItem: EmptyValue {
    public struct ID: Hashable, Codable {
        public var value: Int
        
        public init(value: Int) {
            self.value = value
        }
    }

    public var id: ID
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
    public var firstAirDate: Date?
    public var voteAverage: Double
    public var voteCount: Int
    public var originCountry: [String]
    public var title, originalTitle: String?
    public var releaseDate: Date?
    public var video: Bool

    public init(id: ID,
         adult: Bool,
         backdropPath: String? = nil,
         name: String? = nil,
         originalLanguage: String,
         originalName: String? = nil,
         overview: String,
         posterPath: String? = nil,
         mediaType: String,
         genreIds: [Int],
         popularity: Double,
         firstAirDate: Date? = nil,
         voteAverage: Double,
         voteCount: Int,
         originCountry: [String],
         title: String? = nil,
         originalTitle: String? = nil,
         releaseDate: Date? = nil,
         video: Bool)
    {
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.name = name
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.posterPath = posterPath
        self.mediaType = mediaType
        self.genreIds = genreIds
        self.popularity = popularity
        self.firstAirDate = firstAirDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.originCountry = originCountry
        self.title = title
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.video = video
    }
}

// MARK: - Hashable, Codable, Identifiable

extension SearchItem: Hashable, Codable, Identifiable {}

// MARK: - Faking

extension SearchItem: Faking {
    public init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        adult = false
        backdropPath = "/uGy4DCmM33I7l86W7iCskNkvmLD.jpg"
        name = "Rick and Morty"
        originalLanguage = "en"
        originalName = "Rick and Morty"
        overview = "Rick is a mentally-unbalanced but scientifically gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school."
        posterPath = "/cvhNj9eoRBe5SxjCbQTkh05UP5K.jpg"
        mediaType = "tv"
        genreIds = [16, 35, 10765, 10759]
        popularity = 239.592
        firstAirDate = Date()
        voteAverage = 8.717
        voteCount = 8217
        originCountry = ["US"]
        video = false
    }
}

// MARK: - empty

public extension SearchItem {
    static var empty = SearchItem(
        id: .init(value: Int.random(in: Int.min ... 0)),
        adult: false,
        originalLanguage: "",
        overview: "",
        mediaType: "",
        genreIds: [],
        popularity: 0.0,
        voteAverage: 0.0,
        voteCount: 0,
        originCountry: [],
        video: false
    )
}

// MARK: - Test

public extension SearchItem {
    static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        adult: Bool = false,
        backdropPath: String = "/uGy4DCmM33I7l86W7iCskNkvmLD.jpg",
        name: String = "Rick and Morty",
        originalLanguage: String = "en",
        originalName: String = "Rick and Morty",
        overview: String = "Rick is a mentally-unbalanced but scientifically gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school.",
        posterPath: String = "/cvhNj9eoRBe5SxjCbQTkh05UP5K.jpg",
        mediaType: String = "tv",
        genreIds: [Int] = [16, 35, 10765, 10759],
        popularity: Double = 239.592,
        firstAirDate: Date = .testItem,
        voteAverage: Double = 8.717,
        voteCount: Int = 8217,
        originCountry: [String] = ["US"],
        title: String? = nil,
        originalTitle: String? = nil,
        releaseDate: Date? = nil,
        video: Bool = false
    ) -> Self {
        .init(
            id: id,
            adult: adult,
            backdropPath: backdropPath,
            name: name,
            originalLanguage: originalLanguage,
            originalName: originalName,
            overview: overview,
            posterPath: posterPath,
            mediaType: mediaType,
            genreIds: genreIds,
            popularity: popularity,
            firstAirDate: firstAirDate,
            voteAverage: voteAverage,
            voteCount: voteCount,
            originCountry: originCountry,
            title: title,
            originalTitle: originalTitle,
            releaseDate: releaseDate,
            video: video
        )
    }

    static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: $0)) }
    }

    static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: $0) }
    }
}

// MARK: - asSearchItem

public extension SearchItemRemote {
    var asSearchItem: SearchItem {
        .init(id: .init(value: id),
              adult: adult,
              backdropPath: backdropPath,
              name: name,
              originalLanguage: originalLanguage,
              originalName: originalName,
              overview: overview,
              posterPath: posterPath,
              mediaType: mediaType,
              genreIds: genreIds,
              popularity: popularity,
              firstAirDate: DateFormatter.customIso8601ShortFromServer.date(from: firstAirDate ?? ""),
              voteAverage: voteAverage,
              voteCount: voteCount,
              originCountry: originCountry,
              title: title,
              originalTitle: originalTitle,
              releaseDate: DateFormatter.customIso8601ShortFromServer.date(from: ""),
              video: video)
    }
}

// MARK: - SearchItem

public extension SearchItem {
    var theTitle: String { title ?? name ?? "" }
    var year: String { releaseDate?.asYearString ?? firstAirDate?.asYearString ?? "" }
    var rating: Int { Int(voteAverage * 10) }

    func genres(action: @escaping (Genre.ID) -> Genre?) -> String {
        let genres = genreIds.compactMap { action(.init(value: $0)) }
        return genres.map(\.name).joined(separator: " • ")
    }
}
