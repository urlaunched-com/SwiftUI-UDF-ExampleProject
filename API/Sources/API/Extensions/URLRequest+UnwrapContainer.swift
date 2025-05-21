//
//  URLRequest+UnwrapContainer.swift
//
//
//  Created by Alexander Sharko on 04.01.2023.
//

import Foundation

public extension URLRequest {
    func loadValidResult<Item: Decodable>(
        type _: Item.Type,
        unwrapBy key: String = "",
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601
    ) async throws -> Item {
        let (data, response) = try await URLSession.shared.data(for: self)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        if let codingKey = CodingUserInfoKey(rawValue: kUnwrapKey), !key.isEmpty {
            decoder.userInfo[codingKey] = key
            return try decoder.decode(UnwrapContainer<Item>.self, from: validate(data, response)).value
        }
        return try decoder.decode(Item.self, from: validate(data, response))
    }

    func loadValidResult() async throws {
        let (data, response) = try await URLSession.shared.data(for: self)
        try validate(data, response)
    }
}

let kUnwrapKey = "unwrap_key"

private struct UnwrapContainer<Value: Decodable>: Decodable {
    let value: Value

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }

        var intValue: Int?
        init?(intValue _: Int) { return nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        let keys = container.allKeys

        if let codingKey = CodingUserInfoKey(rawValue: kUnwrapKey),
           let wrapKey = decoder.userInfo[codingKey] as? String,
           let decodeKey = DynamicCodingKeys(stringValue: wrapKey)
        {
            value = try container.decode(decodeKey)
        } else {
            value = try container.decode(keys.first!)
        }
    }
}
