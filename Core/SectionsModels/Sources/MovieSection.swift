//
//  MovieSection.swift
//  Flick
//
//  Created by Alexander Sharko on 06.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import Localizations

public enum MovieSection: Section {
    case popular
    case nowPlaying
    case upcoming
    case topRated

    public var id: Self { self }

    public var title: String {
        switch self {
        case .popular: LocalizationsStrings.Home.popularMoviesSectionTitle
        case .nowPlaying: LocalizationsStrings.Home.nowPlayingMoviesSectionTitle
        case .upcoming: LocalizationsStrings.Home.upcomingMoviesSectionTitle
        case .topRated: LocalizationsStrings.Home.topRatedMoviesSectionTitle
        }
    }

    public var urlValue: String {
        switch self {
        case .popular: "popular"
        case .nowPlaying: "now_playing"
        case .upcoming: "upcoming"
        case .topRated: "top_rated"
        }
    }
}
