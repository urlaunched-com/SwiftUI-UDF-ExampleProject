//
//  ShowSection.swift
//  Flick
//
//  Created by Alexander Sharko on 06.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import Localizations

enum ShowSection: Section {
    case popular
    case airingToday
    case onTheAir
    case topRated

    var id: Self { self }
    var title: String {
        switch self {
        case .popular: Localization.homePopularShowsSectionTitle()
        case .airingToday: Localization.homeAiringTodayShowsSectionTitle()
        case .onTheAir: Localization.homeOnTVShowsSectionTitle()
        case .topRated: Localization.homeTopRatedShowsSectionTitle()
        }
    }

    var urlValue: String {
        switch self {
        case .popular: "popular"
        case .airingToday: "airing_today"
        case .onTheAir: "on_the_air"
        case .topRated: "top_rated"
        }
    }
}
