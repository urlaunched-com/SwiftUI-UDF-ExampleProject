//
//  ItemsResponse.swift
//
//
//  Created by Alexander Sharko on 05.12.2022.
//

import Foundation

public struct ItemsResponse<I: Decodable>: Decodable {
    public var page: Int
    public var results: LossyCodableList<I>
    public var totalPages: Int
    public var totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = container.decodeSafely(.page) ?? 0
        results = container.decodeSafely(.results) ?? .init(elements: [])
        totalPages = container.decodeSafely(.totalPages) ?? 0
        totalResults = container.decodeSafely(.totalResults) ?? 0
    }

    var items: [I] {
        get { results.elements }
        set { results.elements = newValue }
    }
}
