//
//  FlickDeepLink.swift
//  Flick
//
//  Created by Maksym Horobets on 22.10.2026.
//  © 2026 You are launched
//

import Common
import Foundation
import HomeModule
import ItemDetailsModule
import Models

/// What a URL asks the app to open, before any navigation.
enum FlickDeepLink: Equatable {
    case movieSection(MovieSection)
    case showSection(ShowSection)
    case movie(Movie.ID)
}

// MARK: - Parse

extension FlickDeepLink {
    /// The only place that knows Flick's URL format:
    /// `flick://movies/<section>` and `flick://shows/<section>`, e.g. `flick://movies/now_playing`,
    /// and `flick://movies/<TMDB id>` for one movie, e.g. `flick://movies/550`.
    init?(url: URL) {
        let segments = url.linkSegments
        guard segments.count == 2 else {
            return nil
        }

        switch segments[0] {
        case "movies":
            if let section = MovieSection.allCases.first(where: { $0.urlValue == segments[1] }) {
                self = .movieSection(section)
            } else if let id = Int(segments[1]) {
                self = .movie(Movie.ID(value: id))
            } else {
                return nil
            }

        case "shows":
            guard let section = ShowSection.allCases.first(where: { $0.urlValue == segments[1] }) else {
                return nil
            }
            self = .showSection(section)

        default:
            return nil
        }
    }
}

// MARK: - Route

extension FlickDeepLink {
    var tab: TabBarItem {
        switch self {
        case .movieSection, .showSection, .movie: .home
        }
    }

    var path: [any Hashable & Sendable] {
        switch self {
        case let .movieSection(section): [HomeLink.movieSection(section)]
        case let .showSection(section): [HomeLink.showSection(section)]
        case let .movie(id): [ItemDetailsTarget.movie(id)]
        }
    }
}

private extension URL {
    /// `flick://movies/popular` and `https://<domain>/movies/popular` both give `["movies", "popular"]`.
    var linkSegments: [String] {
        let path = pathComponents.filter { $0 != "/" }
        guard scheme == "flick", let host = host() else {
            return path
        }
        return [host] + path
    }
}
