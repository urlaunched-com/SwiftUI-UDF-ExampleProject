//
//  ItemDetailsAPIClient.swift
//
//
//  Created by Alexander Sharko on 17.01.2023.
//

import Foundation

public enum ItemDetailsAPIClient {
    public static func loadMovie(movieId: Int) async throws -> MovieRemote {
        let request = URLRequest.request(for: .movie(id: movieId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
        }
        return try await request.loadValidResult(type: MovieRemote.self)
    }

    public static func loadShow(showId: Int) async throws -> ShowRemote {
        let request = URLRequest.request(for: .show(id: showId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
        }
        return try await request.loadValidResult(type: ShowRemote.self)
    }

    public static func loadMovieCast(movieId: Int) async throws -> [CastRemote] {
        let request = URLRequest.request(for: .movieCast(id: movieId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
        }
        return try await request.loadValidResult(type: LossyCodableList<CastRemote>.self, unwrapBy: "cast").elements
    }

    public static func loadShowCast(showId: Int) async throws -> [CastRemote] {
        let request = URLRequest.request(for: .showCast(id: showId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
        }
        return try await request.loadValidResult(type: LossyCodableList<CastRemote>.self, unwrapBy: "cast").elements
    }

    public static func loadMovieReviews(movieId: Int, page: Int) async throws -> [ReviewRemote] {
        let request = URLRequest.request(for: .movieReviews(id: movieId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
            URLQueryItem(name: URLParameter.page.rawValue, value: "\(page)")
        }
        return try await request.loadValidResult(type: ItemsResponse<ReviewRemote>.self).items
    }

    public static func loadShowReviews(showId: Int, page: Int) async throws -> [ReviewRemote] {
        let request = URLRequest.request(for: .showReviews(id: showId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
            URLQueryItem(name: URLParameter.page.rawValue, value: "\(page)")
        }
        return try await request.loadValidResult(type: ItemsResponse<ReviewRemote>.self).items
    }

    public static func loadMovieRecommendations(movieId: Int, page: Int) async throws -> [MovieRemote] {
        let request = URLRequest.request(for: .movieRecommendations(id: movieId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
            URLQueryItem(name: URLParameter.page.rawValue, value: "\(page)")
        }
        return try await request.loadValidResult(type: ItemsResponse<MovieRemote>.self).items
    }

    public static func loadShowRecommendations(showId: Int, page: Int) async throws -> [ShowRemote] {
        let request = URLRequest.request(for: .showRecommendations(id: showId)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
            URLQueryItem(name: URLParameter.page.rawValue, value: "\(page)")
        }
        return try await request.loadValidResult(type: ItemsResponse<ShowRemote>.self).items
    }
}
