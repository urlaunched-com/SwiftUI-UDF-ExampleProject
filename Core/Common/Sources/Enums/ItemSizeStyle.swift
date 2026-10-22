//
//  ItemSizeStyle.swift
//  Flick
//
//  Created by Valentin Petrulia on 13.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import CoreFoundation

public enum ItemSizeStyle {
    case `default`, main
    public var coverSize: CGSize {
        switch self {
        case .main: return .init(width: 202, height: 283)
        case .default: return .init(width: 135, height: 189)
        }
    }

    public var isMain: Bool { self == .main }
}
