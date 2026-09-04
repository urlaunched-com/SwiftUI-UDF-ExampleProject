//
//  RatingCircle.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import SwiftUI
import SwiftUI_Kit

public struct RatingCircle: View {
    var value: String
    var strokeColor: Color
    var strokeWidth: CGFloat = 2
    var backgroundColor: Color = .clear
    
    public init(
        value: String,
        strokeColor: Color,
        strokeWidth: CGFloat = 2,
        backgroundColor: Color = .clear
    ) {
        self.value = value
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
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
