//
//  View+RedactedMode.swift
//  Flick
//
//  Created by Alexander Sharko on 07.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import SwiftUI_Kit

extension View {
    func animatedRedacted(_ isActive: Bool) -> some View {
        modifier(
            AnimatedRedactedModifier(
                isActive: isActive,
                backgroundColor: .flSecondary,
                overlayGradient: .init(
                    colors: [.clear, .flRedacted, .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
        )
    }
}

struct IsRedactedKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var isRedacted: Bool {
        get { self[IsRedactedKey.self] }
        set { self[IsRedactedKey.self] = newValue }
    }
}

extension View {
    func isRedacted(_ isRedacted: Bool) -> some View {
        environment(\.isRedacted, isRedacted)
    }
}
