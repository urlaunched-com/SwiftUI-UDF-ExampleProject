//
//  CastCardView.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI

struct CastCardView: View {
    @Environment(\.isRedacted) var isRedacted
    let cast: Cast
    let size: CGSize
    var lineLimit: Int = 2

    var body: some View {
        VStack(spacing: 12) {
            Group {
                if let profilePath = cast.profilePath {
                    ImageContainer(
                        size: size,
                        path: profilePath,
                        type: .profile
                    )
                } else {
                    Color
                        .flSecondary
                        .overlay(Image.castPlaceholder)
                }
            }
            .frame(size)
            .animatedRedacted(isRedacted)
            .clipShape(RoundedRectangle(cornerRadius: 14))

            if !isRedacted {
                VStack(spacing: 2) {
                    Text(cast.name)
                        .customFont(.caption)
                        .foregroundStyle(.flText)
                    Text(cast.character)
                        .customFont(.caption2)
                        .foregroundStyle(.flGray)
                }
                .multilineTextAlignment(.center)
                .lineLimit(lineLimit)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CastCardView(
        cast: .fakeItem(),
        size: .init(width: 104, height: 129)
    )
}
