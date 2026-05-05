//
//  Common.swift
//  Flick
//
//  Created by Bogdan Petkanych on 04.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import SwiftUI
@preconcurrency import Models
import Localizations

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

public let Localization = R.string.localizable
