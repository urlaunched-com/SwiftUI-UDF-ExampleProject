//
//  PrimaryButtonStyle.swift
//
//
//  Created by Alexander Sharko on 11.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
    public var fillColor: Color

    public init(fillColor: Color) {
        self.fillColor = fillColor
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(fillColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 1)
                            .fill(Color.flMainPink)
                    )
            )
            .opacity(configuration.isPressed ? 0.2 : 1.0)
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static func primary(fillColor: Color = .flMainPink) -> PrimaryButtonStyle { PrimaryButtonStyle(fillColor: fillColor) }
}

// MARK: - Preview

#Preview {
    VStack {
        Button("Hello World!") {}
            .buttonStyle(.primary())

        Button(action: {}) {
            Image.logoutUp
        }
        .buttonStyle(.primary(fillColor: .flWhite))
    }
}
