//
//  PrimaryButton.swift
//  Flick
//
//  Created by Alexander Sharko on 18.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct PrimaryButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
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
