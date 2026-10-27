//
//  ReviewsRouting.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//

import SwiftUI
import UDF
import Models
import Common

/// Routes the Reviews flow asks its host to resolve. Everything else is resolved inside the flow.
public enum ReviewsRoute: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}
