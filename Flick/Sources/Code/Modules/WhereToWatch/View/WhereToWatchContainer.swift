//
//  WhereToWatchContainer.swift
//  Flick
//
//  Created by Arthur Zavolovych on 16.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import FlagKit
import UDF

struct WhereToWatchContainer: Container {
    typealias ContainerComponent = WhereToWatchComponent

    let item: any Item

    func scope(for state: AppState) -> Scope {
        state.homeFlow // hardcoded placeholder
    }

    func map(store _: EnvironmentStore<AppState>) -> WhereToWatchComponent.Props {
        .init(
            item: item,
            countries: {
                let codes = [
                    "AL", "SA", "AM", "AZ", "BY", "BA", "BG", "MM", "CN", "HR", "CZ", "DK", "MV", "NL",
                    "EE", "FJ", "FI", "FR", "GE", "DE", "GR", "HT", "IN", "HU", "ID", "GB", "IS", "IT",
                    "JP", "GL", "KZ", "KG", "KR", "LT", "LV", "MK", "MT", "MN", "NP", "NO", "PL", "PT",
                    "RO", "RS", "SK", "SI", "SO", "ES", "SE", "TJ", "TH", "BO", "TM", "TR", "UA", "UZ", "VN",
                ]

                return codes.compactMap { code in
                    guard let flag = Flag(countryCode: code) else { return nil }
                    let image = flag.originalImage
                    return .init(title: code, image: image)
                }
            }(),
            providers: Provider.fakeItems(count: 3)
        )
    }
}
