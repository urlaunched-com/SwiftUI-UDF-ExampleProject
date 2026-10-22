//
//  PrimaryButton.swift
//  Flick
//
//  Created by Bogdan Petkanych on 06.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .customFont(.title3)
                .foregroundStyle(.flWhite)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.primary())
    }
}

// MARK: - Preview

#Preview {
    PrimaryButton(title: "Start", action: {})
}
