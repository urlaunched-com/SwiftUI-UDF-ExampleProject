//
//  ItemDetailsLinkRouting.swift
//  Flick
//
//  Created by Maksym Horobets on 26.10.2026.
//  © 2026 You are launched
//

import SwiftUI
import UDF

/// Builds the details page an ``ItemDetailsTarget`` link opens.
public struct ItemDetailsLinkRouting<AppState: ItemDetailsFeature>: Routing {
    public init() {}

    public func view(for target: ItemDetailsTarget) -> some View {
        ItemDetailsContainer<AppState>(id: target)
            // A link that replaces the stack lands at the same depth as the page it replaces; a new identity
            // makes the new page load its own item instead of keeping the previous one.
            .id(target)
    }
}
