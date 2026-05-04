//
//  RatingCircle.swift
//  Flick
//
//  Created by Alexander Sharko on 18.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI

struct RatingCircle: View {
    var value: String
    var strokeColor: Color
    var strokeWidth: CGFloat = 2
    var backgroundColor: Color = .clear

    var body: some View {
        Circle()
            .fill(backgroundColor)
            .overlay(
                strokeColor
                    .clipShape(
                        Circle()
                            .stroke(style: .init(lineWidth: strokeWidth))
                    )
            )
            .frame(54)
            .overlay(
                Text(value)
                    .customFont(.body)
                    .foregroundStyle(.flText)
            )
    }
}

// MARK: - Preview

#Preview {
    RatingCircle(
        value: "57%",
        strokeColor: .flSystemRed,
        strokeWidth: 2,
        backgroundColor: .flMain
    )
}
