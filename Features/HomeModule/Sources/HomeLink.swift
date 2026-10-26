//
//  HomeLink.swift
//  Flick
//
//  Created by Maksym Horobets on 22.10.2026.
//  © 2026 You are launched
//

import Models
import SwiftUI
import UDF

/// The Home screens that can be opened directly, from inside the flow or from a deep link.
public enum HomeLink: Hashable, Sendable {
    /// The full list of a movie section.
    case movieSection(MovieSection)
    /// The full list of a show section.
    case showSection(ShowSection)
}

extension HomeLink {
    init?(section: any Models.Section) {
        switch section {
        case let section as MovieSection: self = .movieSection(section)
        case let section as ShowSection: self = .showSection(section)
        default: return nil
        }
    }
}

/// Builds the screen a ``HomeLink`` opens.
public struct HomeLinkRouting<AppState: HomeFeature>: Routing {
    public init() {}

    public func view(for link: HomeLink) -> some View {
        Group {
            switch link {
            case let .movieSection(section):
                SectionDetailsContainer<AppState>(section: section)
            case let .showSection(section):
                SectionDetailsContainer<AppState>(section: section)
            }
        }
        // A link that replaces the stack lands at the same depth as the list it replaces; a new identity
        // makes the new list load its own section instead of keeping the previous one.
        .id(link)
    }
}
