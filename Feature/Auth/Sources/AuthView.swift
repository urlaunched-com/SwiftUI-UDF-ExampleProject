//
//  AuthView.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI

struct AuthView<Content: View>: View {
    var title: String
    var content: () -> Content

    var body: some View {
        ZStack {
            Color.flMain
                .overlay(Image.authCircles, alignment: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Text(title)
                    .customFont(.title)
                    .foregroundStyle(.flText)
                    .padding(.top, 30)
                content()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 8) {
                    Image.videoNormal.foregroundStyle(.flMainPink)
                    Text(Localization.authNavigationTitle())
                        .customFont(.title3)
                        .foregroundColor(.flText)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Preview

#Preview {
    AuthView(title: "Create your account") {
        Spacer()
    }
    .embedInNavigationStack()
}
