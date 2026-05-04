//
//  ReviewDetailsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF

struct ReviewDetailsComponent: Component {
    struct Props {
        var review: Review
    }

    var props: Props

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ReviewHeaderView(review: props.review, placeholderColor: .flSecondary)
                    .padding(.horizontal, 10)
                Text(props.review.content)
                    .customFont(.body)
                    .foregroundStyle(.flText)
            }
            .padding()
        }
        .customNavigationTitle(Localization.itemDetailsReviewsNavigationTitle())
        .background(Color.flMain.edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Preview

#Preview {
    ReviewDetailsComponent(
        props: .init(
            review: .fakeItem()
        )
    )
}
