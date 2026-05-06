//
//  Provider.swift
//  Flick
//
//  Created by Arthur Zavolovych on 17.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import SwiftFoundation
import Common
import Localizations

public struct Provider {
    public var type: ProviderType
    public var items: [ProviderItem]

    public init(type: ProviderType, items: [ProviderItem]) {
        self.type = type
        self.items = items
    }
}

public struct ProviderItem {
    public struct ID: Hashable, Codable {
        public var value: Int
    }

    public var id: ID
    public var logoPath: String?
    public var name: String
    public var displayPriority: Int

    public init(id: ID, logoPath: String? = nil, name: String, displayPriority: Int) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.displayPriority = displayPriority
    }
}

// MARK: - ProviderType

public enum ProviderType {
    case flatRate
    case rent
    case buy

    public var localizableTitle: String {
        switch self {
        case .flatRate, .rent:
            Localization.whereToWatchStreamTitle()
        case .buy:
            Localization.whereToWatchBuyTitle()
        }
    }
}

// MARK: - Faking

extension Provider: Faking {
    public init() {
        type = .flatRate
        items = ProviderItem.fakeItems(count: 4)
    }
}

extension ProviderItem: Faking {
    public init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        logoPath = "/peURlLlr8jggOwK53fJ5wdQl05y.jpg"
        name = "Apple TV"
        displayPriority = 4
    }
}
