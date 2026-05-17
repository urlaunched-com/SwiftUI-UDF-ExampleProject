//
//  CastCardView.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import Models

public struct CastCardView<IV: View>: View {
    @Environment(\.isRedacted) var isRedacted
    let cast: Cast
    let size: CGSize
    var lineLimit: Int = 2
    var imageView: () -> IV
    
    public init(
        cast: Cast,
        size: CGSize,
        @ViewBuilder imageView: @escaping () -> IV,
        lineLimit: Int = 2
    ) {
        self.cast = cast
        self.size = size
        self.lineLimit = lineLimit
        self.imageView = imageView
    }

    public var body: some View {
        VStack(spacing: 12) {
            Group {
                if let profilePath = cast.profilePath {
                    imageView()
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
        size: .init(width: 104, height: 129),
        imageView: { EmptyView() }
    )
}
