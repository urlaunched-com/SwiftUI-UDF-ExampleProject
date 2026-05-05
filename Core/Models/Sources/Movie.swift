//
//  Movie.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation
import UDF
import Common

public struct Movie: Item {
    public struct ID: Hashable, Codable {
        public var value: Int
        
        public init(value: Int) {
            self.value = value
        }
    }

    public var id: ID
    public var posterPath: String?
    public var adult: Bool
    public var overview: String
    public var releaseDate: Date?
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
    public var runtime: Minutes?

    public init(
        id: ID,
        posterPath: String?,
        adult: Bool,
        overview: String,
        releaseDate: Date?,
        genreIds: [Int],
        originalTitle: String,
        originalLanguage: String,
        title: String,
        backdropPath: String?,
        popularity: Double,
        voteCount: Int,
        video: Bool,
        voteAverage: Double,
        revenue: Int,
        budget: Int,
        status: String,
        runtime: Minutes?
    ) {
        self.id = id
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
        self.revenue = revenue
        self.budget = budget
        self.status = status
        self.runtime = runtime
    }
}

// MARK: - Hashable, Codable

extension Movie: Hashable, Codable {}

// MARK: - Faking

extension Movie: Faking {
    public init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        posterPath = "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg"
        adult = false
        overview = "From DC Comics"
        releaseDate = Date()
        genreIds = [14, 28, 80]
        originalTitle = "Suicide Squad"
        originalLanguage = "en"
        title = "Suicide Squad"
        backdropPath = "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg"
        popularity = 48.261451
        voteCount = 1466
        video = false
        voteAverage = 5.9
        revenue = 100_853_753
        budget = 63_000_000
        status = "Released"
        runtime = 139
    }
}

// MARK: - empty

public extension Movie {
    static var empty = Movie(
        id: .init(value: Int.random(in: Int.min ... 0)),
        posterPath: nil,
        adult: false,
        overview: "",
        releaseDate: nil,
        genreIds: [],
        originalTitle: "",
        originalLanguage: "",
        title: "",
        backdropPath: nil,
        popularity: 0,
        voteCount: 0,
        video: false,
        voteAverage: 0,
        revenue: 0,
        budget: 0,
        status: "",
        runtime: nil
    )
}

// MARK: - Test

public extension Movie {
    static func testItem(
        id: ID = .init(value: Int.random(in: Int.min ... 0)),
        posterPath: String = "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg",
        adult: Bool = false,
        overview: String = "From DC Comics",
        releaseDate: Date = .testItem,
        genreIds: [Int] = [14, 28, 80],
        originalTitle: String = "Suicide Squad",
        originalLanguage: String = "en",
        title: String = "Suicide Squad",
        backdropPath: String = "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
        popularity: Double = 48.261451,
        voteCount: Int = 1466,
        video: Bool = false,
        voteAverage: Double = 5.9,
        revenue: Int = 100_853_753,
        budget: Int = 63_000_000,
        status: String = "Released",
        runtime: Minutes? = 139
    ) -> Self {
        .init(
            id: id,
            posterPath: posterPath,
            adult: adult,
            overview: overview,
            releaseDate: releaseDate,
            genreIds: genreIds,
            originalTitle: originalTitle,
            originalLanguage: originalLanguage,
            title: title,
            backdropPath: backdropPath,
            popularity: popularity,
            voteCount: voteCount,
            video: video,
            voteAverage: voteAverage,
            revenue: revenue,
            budget: budget,
            status: status,
            runtime: runtime
        )
    }

    static func testItems(count: Int) -> [Self] {
        (0 ..< count).map { .testItem(id: ID(value: $0)) }
    }

    static func testItemIds(count: Int) -> [Self.ID] {
        (0 ..< count).map { ID(value: $0) }
    }
}

// MARK: - asMovie

public extension MovieRemote {
    var asMovie: Movie {
        .init(
            id: .init(value: id),
            posterPath: posterPath,
            adult: adult,
            overview: overview,
            releaseDate: DateFormatter.customIso8601ShortFromServer.date(from: releaseDate),
            genreIds: genreIds,
            originalTitle: originalTitle,
            originalLanguage: originalLanguage,
            title: title,
            backdropPath: backdropPath,
            popularity: popularity,
            voteCount: voteCount,
            video: video,
            voteAverage: voteAverage,
            revenue: revenue,
            budget: budget,
            status: status,
            runtime: runtime
        )
    }
}

// MARK: - Item

public extension Movie {
    var year: String { releaseDate?.asYearString ?? "" }
    var duration: Minutes { runtime ?? 0 }
    var rating: Int { Int(voteAverage * 10) }
}

// MARK: - Mergeable

extension Movie: Mergeable {
    public func merging(_ newValue: Movie) -> Movie {
        filled(from: newValue) { filledValue, oldValue in
            filledValue.genreIds = newValue.genreIds.isEmpty ? oldValue.genreIds : newValue.genreIds
            filledValue.budget = newValue.budget == 0 ? oldValue.budget : newValue.budget
            filledValue.status = newValue.status.isEmpty ? oldValue.status : newValue.status
            filledValue.runtime = newValue.runtime == nil ? oldValue.runtime : newValue.runtime
            filledValue.revenue = newValue.revenue == 0 ? oldValue.revenue : newValue.revenue
        }
    }
}
