//
//  LossyCodableList.swift
//
//
//  Created by Alexander Sharko on 10.02.2023.
//

import Foundation
import SwiftUI

public struct LossyCodableList<Element> {
    public var elements: [Element]
}

extension LossyCodableList: Decodable where Element: Decodable {
    private struct ElementWrapper: Decodable {
        var element: Element?

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            element = try? container.decode(Element.self)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let wrappers = try container.decode([ElementWrapper].self)
        elements = wrappers.compactMap(\.element)
    }
}
