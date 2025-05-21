//
//  Show.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation
import UDF

struct Show: Item {
    struct ID: Hashable, Codable {
        var value: Int
    }

    var id: ID
    var posterPath: String?
    var popularity: Double
    var backdropPath: String?
    var voteAverage: Double
    var overview: String
    var firstAirDate: Date?
    var originCountry: [String]
    var genreIds: [Int]
    var originalLanguage: String
    var voteCount: Int
    var name: String
    var originalName: String
    var episodeRunTime: [Minutes]
    var status: String
    var networks: [Network]
    var type: String

    init(
        id: ID,
        posterPath: String?,
        popularity: Double,
        backdropPath: String?,
        voteAverage: Double,
        overview: String,
        firstAirDate: Date?,
        originCountry: [String],
        genreIds: [Int],
        originalLanguage: String,
        voteCount: Int,
        name: String,
        originalName: String,
        episodeRunTime: [Minutes],
        status: String,
        networks: [Network],
        type: String
    ) {
        self.id = id
        self.posterPath = posterPath
        self.popularity = popularity
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.originCountry = originCountry
        self.genreIds = genreIds
        self.originalLanguage = originalLanguage
        self.voteCount = voteCount
        self.name = name
        self.originalName = originalName
        self.episodeRunTime = episodeRunTime
        self.status = status
        self.networks = networks
        self.type = type
    }
}

// MARK: - Hashable, Codable

extension Show: Hashable, Codable {}

// MARK: - Faking

extension Show: Faking {
    init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        posterPath = "/vC324sdfcS313vh9QXwijLIHPJp.jpg"
        popularity = 47.432451
        backdropPath = "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg"
        voteAverage = 5.04
        overview = "Based on the knew."
        firstAirDate = Date()
        originCountry = ["US"]
        genreIds = [18, 9648]
        originalLanguage = "en"
        voteCount = 133
        name = "Pretty Little Liars"
        originalName = "Pretty Little Liars"
        episodeRunTime = [60]
        status = "Ended"
        networks = Network.fakeItems()
        type = "Scripted"
    }
}

// MARK: - empty

extension Show {
    static var empty = Show(
        id: .init(value: Int.random(in: Int.min ... 0)),
        posterPath: "",
        popularity: 0,
        backdropPath: "",
        voteAverage: 0,
        overview: "",
        firstAirDate: nil,
        originCountry: [],
        genreIds: [],
        originalLanguage: "",
        voteCount: 0,
        name: "",
        originalName: "",
        episodeRunTime: [],
        status: "",
        networks: [],
        type: ""
    )
}

// MARK: - Test

extension Show {
    public static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        posterPath: String = "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
        popularity: Double = 47.432451,
        backdropPath: String = "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
        voteAverage: Double = 5.04,
        overview: String = "Based on the knew.",
        firstAirDate: Date = .testItem,
        originCountry: [String] = ["US"],
        genreIds: [Int] = [18, 9648],
        originalLanguage: String = "en",
        voteCount: Int = 133,
        name: String = "Pretty Little Liars",
        originalName: String = "Pretty Little Liars",
        episodeRunTime: [Minutes] = [60],
        status: String = "Ended",
        networks: [Network] = Network.testItems(count: 3),
        type: String = "Scripted"
    ) -> Self {
        .init(
            id: id,
            posterPath: posterPath,
            popularity: popularity,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            overview: overview,
            firstAirDate: firstAirDate,
            originCountry: originCountry,
            genreIds: genreIds,
            originalLanguage: originalLanguage,
            voteCount: voteCount,
            name: name,
            originalName: originalName,
            episodeRunTime: episodeRunTime,
            status: status,
            networks: networks,
            type: type
        )
    }

    public static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: $0)) }
    }

    public static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: $0) }
    }
}

// MARK: - asShow

extension ShowRemote {
    var asShow: Show {
        .init(
            id: .init(value: id),
            posterPath: posterPath,
            popularity: popularity,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            overview: overview,
            firstAirDate: DateFormatter.customIso8601ShortFromServer.date(from: firstAirDate),
            originCountry: originCountry,
            genreIds: genreIds,
            originalLanguage: originalLanguage,
            voteCount: voteCount,
            name: name,
            originalName: originalName,
            episodeRunTime: episodeRunTime,
            status: status,
            networks: networks.map(\.asNetwork),
            type: type
        )
    }
}

// MARK: - Item

extension Show {
    var title: String { name }
    var year: String { firstAirDate?.asYearString ?? "" }
    var duration: Minutes { episodeRunTime.first ?? 0 }
    var rating: Int { Int(voteAverage * 10) }
}

// MARK: - Mergeable

extension Show: Mergeable {
    func merging(_ newValue: Show) -> Show {
        filled(from: newValue) { filledValue, oldValue in
            filledValue.genreIds = newValue.genreIds.isEmpty ? oldValue.genreIds : newValue.genreIds
            filledValue.episodeRunTime = newValue.episodeRunTime.isEmpty ? oldValue.episodeRunTime : newValue.episodeRunTime
            filledValue.status = newValue.status.isEmpty ? oldValue.status : newValue.status
            filledValue.networks = newValue.networks.isEmpty ? oldValue.networks : newValue.networks
            filledValue.type = newValue.type.isEmpty ? oldValue.type : newValue.type
        }
    }
}

// MARK: - Computed properties

extension Show {
    var typeText: String { type.isEmpty ? "-" : type }
}
