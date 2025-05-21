//
//  SectionHeaderView.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var seeAllAction: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .customFont(.headline)
                .foregroundStyle(.flText)
            Spacer()
            Button(action: seeAllAction) {
                HStack(spacing: 0) {
                    Text(Localization.homeSectionHeaderButtonTitle())
                        .customFont(.subheadline)
                        .foregroundStyle(.flMainPink)
                    Image.Arrow.right
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 21)
                }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview

#Preview {
    SectionHeaderView(
        title: "Popular",
        seeAllAction: {}
    )
}
