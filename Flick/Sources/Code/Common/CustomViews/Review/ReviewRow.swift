//
//  ReviewRow.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI

struct ReviewRow: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ReviewHeaderView(review: review)

            Text(review.content)
                .customFont(.body)
                .foregroundStyle(Color.flText)
                .lineLimit(5)
                .padding(.leading, 6)
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 16, trailing: 16))
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.flSecondary)
        )
    }
}

// MARK: - Preview

#Preview {
    ReviewRow(review: .fakeItem())
}
