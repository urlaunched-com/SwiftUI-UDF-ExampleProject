//
//  HomeAPIClient.swift
//
//
//  Created by Alexander Sharko on 09.12.2022.
//

import Foundation

public enum HomeAPIClient {
    public static func loadMovies(section: String, page: Int? = nil) async throws -> [MovieRemote] {
        let request = URLRequest.request(for: .movies(section: section)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
            if let page {
                URLQueryItem(name: URLParameter.page.rawValue, value: "\(page)")
            }
        }
        return try await request.loadValidResult(type: ItemsResponse<MovieRemote>.self).items
    }

    public static func loadShows(section: String, page: Int? = nil) async throws -> [ShowRemote] {
        let request = URLRequest.request(for: .shows(section: section)) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
            if let page {
                URLQueryItem(name: URLParameter.page.rawValue, value: "\(page)")
            }
        }
        return try await request.loadValidResult(type: ItemsResponse<ShowRemote>.self).items
    }

    public static func loadMovieGenres() async throws -> [GenreRemote] {
        let request = URLRequest.request(for: .movieGenres) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
        }
        return try await request.loadValidResult(type: LossyCodableList<GenreRemote>.self, unwrapBy: "genres").elements
    }

    public static func loadShowGenres() async throws -> [GenreRemote] {
        let request = URLRequest.request(for: .showGenres) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
        }
        return try await request.loadValidResult(type: LossyCodableList<GenreRemote>.self, unwrapBy: "genres").elements
    }
}
