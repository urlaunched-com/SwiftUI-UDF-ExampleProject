//
//  ReviewDetailsContent.swift
//  Flick
//
//  Created by Bogdan Petkanych on 14.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import SwiftUI
import Common

public enum ReviewDetailsContent: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}
