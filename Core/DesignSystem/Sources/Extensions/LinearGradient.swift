//
//  LinearGradient.swift
//
//
//  Created by Alexander Sharko on 14.11.2022.
//

import SwiftUI

public extension LinearGradient {
    static let primaryBackground: LinearGradient = .init(
        colors: [.flMain, .flGradientMain],
        startPoint: .top,
        endPoint: .bottom
    )
}
