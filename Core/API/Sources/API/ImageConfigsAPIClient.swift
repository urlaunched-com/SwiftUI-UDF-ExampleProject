//
//  ImageConfigsAPIClient.swift
//
//
//  Created by Alexander Sharko on 03.01.2023.
//

import Foundation

public enum ImageConfigsAPIClient {
    public static func loadConfigs() async throws -> ImageConfigsRemote {
        let request = URLRequest.request(for: .configuration) {
            URLQueryItem(name: URLParameter.apiKey.rawValue, value: kTMDBApiKey)
        }
        return try await request.loadValidResult(type: ImageConfigsRemote.self, unwrapBy: "images")
    }
}
