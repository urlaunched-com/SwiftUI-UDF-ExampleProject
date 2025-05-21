//
//  ReviewRatingView.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct ReviewRatingView: View {
    let rating: Int

    var body: some View {
        HStack(spacing: 6) {
            Image.starFill
                .template
                .aspectFit()
                .frame(15)
            Text("\(rating).0")
        }
        .foregroundStyle(.flMain)
        .padding(.vertical, 8)
        .padding(.horizontal, 7)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.flStarYellow)
        )
    }
}

// MARK: - Preview

#Preview {
    ReviewRatingView(rating: 8)
}
