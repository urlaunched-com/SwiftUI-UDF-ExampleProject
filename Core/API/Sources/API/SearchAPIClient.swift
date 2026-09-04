//
//  SearchAPIClient.swift
//
//
//  Created by Oksana Fedorchuk on 26.05.2023.
//

import Foundation

public enum SearchAPIClient {
    public static func loadSearchItems(query: String, page: Int? = nil) async throws -> [SearchItemRemote] {
        let request = URLRequest.request(for: .multiSearch) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
            if let page {
                URLQueryItem(name: URLParameter.page.rawValue, value: "\(page)")
            }
            URLQueryItem(name: URLParameter.query.rawValue, value: "\(query)")
        }
        return try await request.loadValidResult(type: ItemsResponse<SearchItemRemote>.self).items
    }
}
