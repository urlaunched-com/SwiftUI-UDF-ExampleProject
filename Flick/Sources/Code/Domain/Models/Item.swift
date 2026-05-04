//
//  Item.swift
//  Flick
//
//  Created by Alexander Sharko on 06.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import DesignSystem
import Foundation
import SwiftUI

protocol Item: Identifiable, Hashable {
    var title: String { get }
    var year: String { get }
    var rating: Int { get }
    var overview: String { get }
    var duration: Int { get }
    var status: String { get }
    var originalLanguage: String { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var genreIds: [Int] { get }
}

extension Item {
    var durationText: String {
        guard duration > 0 else {
            return ""
        }
        let timeInterval: TimeInterval = Double(duration) * 60
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = [.dropAll]
        return formatter.string(from: timeInterval) ?? ""
    }

    var language: String {
        let locale: NSLocale? = NSLocale(localeIdentifier: "en")
        guard let language = locale?.localizedString(forLanguageCode: originalLanguage), !language.isEmpty else {
            return "-"
        }
        return language
    }

    func genres(action: @escaping (Genre.ID) -> Genre?) -> String {
        let genres = genreIds.compactMap { action(.init(value: $0)) }
        return genres.map(\.name).joined(separator: " • ")
    }

    var ratingColor: Color {
        switch rating {
        case ...39: return .flSystemRed
        case 40 ... 79: return .flStarYellow
        case 80...: return .flGreen
        default: return .flSystemRed
        }
    }

    var statusText: String { status.isEmpty ? "-" : status }
}
