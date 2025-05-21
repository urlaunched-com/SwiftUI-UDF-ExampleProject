//
//  Common.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI

// MARK: - Typealiases

typealias Minutes = Int

let Localization = R.string.localizable

// MARK: - Constants

let kPerPage: Int = 20

// MARK: - AppLink

enum AppLink: String, Identifiable {
    case aboutUs = "https://www.themoviedb.org/about"
    case tmdbAPI = "https://developer.themoviedb.org/docs/getting-started"
    case privacyPolicy = "https://www.themoviedb.org/privacy-policy"

    var id: Self { self }
    var urlValue: URL { URL(string: rawValue)! }
}

// MARK: - Helpers

func areEqual<Lhs: Equatable>(_ lhs: Lhs, _ rhs: some Equatable) -> Bool {
    guard let rhsAs = rhs as? Lhs else {
        return false
    }

    return lhs == rhsAs
}

@ViewBuilder
func buildView(
    item: any Item,
    movieView: (Movie) -> some View,
    showView: (Show) -> some View
) -> some View {
    switch item {
    case let item as Movie:
        movieView(item)
    case let item as Show:
        showView(item)
    default:
        EmptyView()
    }
}
