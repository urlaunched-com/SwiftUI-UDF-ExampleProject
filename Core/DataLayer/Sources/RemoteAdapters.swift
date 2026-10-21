//
//  RemoteAdapters.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import API
import CastModels
import Common
import Foundation
import ImageModels
import MediaModels
import ReviewModels
import SearchModels

// API-to-domain conversion stays inside the data layer.

extension GenreRemote {
    var asGenre: Genre {
        .init(
            id: .init(value: id),
            name: name
        )
    }
}

extension MovieRemote {
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

extension NetworkRemote {
    var asNetwork: Network {
        .init(
            id: .init(value: id),
            name: name
        )
    }
}

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

extension CastRemote {
    var asCast: Cast {
        .init(
            id: .init(value: id),
            name: name,
            character: character,
            profilePath: profilePath
        )
    }
}

extension AuthorRemote {
    var asAuthor: Author {
        .init(
            name: name,
            username: username,
            avatarPath: avatarPath,
            rating: rating
        )
    }
}

extension ReviewRemote {
    var asReview: Review {
        .init(
            id: .init(value: id),
            author: author,
            authorDetails: authorDetails.asAuthor,
            content: content
        )
    }
}

extension SearchItemRemote {
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

extension ImageConfigsRemote {
    var asImageConfigs: ImageConfigs {
        .init(
            baseUrl: baseUrl,
            secureBaseUrl: secureBaseUrl,
            backdropSizes: backdropSizes.compactMap { Int($0.dropFirst()) },
            logoSizes: logoSizes.compactMap { Int($0.dropFirst()) },
            posterSizes: posterSizes.compactMap { Int($0.dropFirst()) },
            profileSizes: profileSizes.compactMap { Int($0.dropFirst()) },
            stillSizes: stillSizes.compactMap { Int($0.dropFirst()) }
        )
    }
}
