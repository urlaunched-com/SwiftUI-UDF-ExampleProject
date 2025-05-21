//
//  ScaledButtonStyle.swift
//
//
//  Created by Alexander Sharko on 06.02.2023.
//

import SwiftUI

public struct ScaledButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
    }
}

public extension ButtonStyle where Self == ScaledButtonStyle {
    static var scaled: ScaledButtonStyle { ScaledButtonStyle() }
}

// MARK: - Preview

#Preview {
    VStack {
        Button(action: {}) {
            Image.logoutRight
        }
        .buttonStyle(.scaled)

        Button("Hello World!") {}
            .buttonStyle(.scaled)

        Button(action: {}) {
            Image.logoutUp
        }
        .buttonStyle(.scaled)
    }
}
