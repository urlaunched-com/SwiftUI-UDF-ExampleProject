//
//  Provider.swift
//  Flick
//
//  Created by Arthur Zavolovych on 17.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import Localizations
import SwiftFoundation

struct Provider {
    var type: ProviderType
    var items: [ProviderItem]

    init(type: ProviderType, items: [ProviderItem]) {
        self.type = type
        self.items = items
    }
}

struct ProviderItem {
    struct ID: Hashable, Codable {
        var value: Int
    }

    var id: ID
    var logoPath: String?
    var name: String
    var displayPriority: Int

    init(id: ID, logoPath: String? = nil, name: String, displayPriority: Int) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.displayPriority = displayPriority
    }
}

// MARK: - ProviderType

enum ProviderType {
    case flatRate
    case rent
    case buy

    var localizableTitle: String {
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
    init() {
        type = .flatRate
        items = ProviderItem.fakeItems(count: 4)
    }
}

extension ProviderItem: Faking {
    init() {
        id = .init(value: Int.random(in: Int.min ... 0))
        logoPath = "/peURlLlr8jggOwK53fJ5wdQl05y.jpg"
        name = "Apple TV"
        displayPriority = 4
    }
}
