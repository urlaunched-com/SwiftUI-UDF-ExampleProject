//
//  ShowSection.swift
//  Flick
//
//  Created by Alexander Sharko on 06.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import Common

public enum ShowSection: Section {
    case popular
    case airingToday
    case onTheAir
    case topRated

    public var id: Self { self }
    public var title: String {
//        switch self {
//        case .popular: Localization.homePopularShowsSectionTitle()
//        case .airingToday: Localization.homeAiringTodayShowsSectionTitle()
//        case .onTheAir: Localization.homeOnTVShowsSectionTitle()
//        case .topRated: Localization.homeTopRatedShowsSectionTitle()
//        }
        return ""
    }

    public var urlValue: String {
        switch self {
        case .popular: "popular"
        case .airingToday: "airing_today"
        case .onTheAir: "on_the_air"
        case .topRated: "top_rated"
        }
    }
}
