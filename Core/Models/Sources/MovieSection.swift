//
//  MovieSection.swift
//  Flick
//
//  Created by Alexander Sharko on 06.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation

//public let Localization = R.string.localizable

public enum MovieSection: Section {
    case popular
    case nowPlaying
    case upcoming
    case topRated

    public var id: Self { self }

    public var title: String {
//        switch self {
//        case .popular: Localization.homePopularMoviesSectionTitle()
//        case .nowPlaying: Localization.homeNowPlayingMoviesSectionTitle()
//        case .upcoming: Localization.homeUpcomingMoviesSectionTitle()
//        case .topRated: Localization.homeTopRatedMoviesSectionTitle()
//        }
        return ""
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
