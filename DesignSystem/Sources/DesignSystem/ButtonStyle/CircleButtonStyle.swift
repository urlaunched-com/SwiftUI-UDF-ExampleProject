//
//  CircleButtonStyle.swift
//
//
//  Created by Alexander Sharko on 11.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI

public struct CircleButtonStyle: ButtonStyle {
    public var fillColor: Color
    public var padding: CGFloat

    public init(fillColor: Color, padding: CGFloat) {
        self.fillColor = fillColor
        self.padding = padding
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .padding(padding)
            .background(
                Circle()
                    .fill(fillColor)
            )
            .opacity(configuration.isPressed ? 0.2 : 1.0)
    }
}

public extension ButtonStyle where Self == CircleButtonStyle {
    static func circle(fillColor: Color = .flPink10, padding: CGFloat = 12) -> CircleButtonStyle {
        CircleButtonStyle(fillColor: fillColor, padding: padding)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        Button(action: {}) {
            Image.logoutRight
        }
        .buttonStyle(.circle())

        Button("Hello World!") {}
            .buttonStyle(.circle())

        Button(action: {}) {
            Image.logoutUp
        }
        .buttonStyle(.circle(fillColor: .flOnboardBlue.opacity(0.1)))
    }
}
