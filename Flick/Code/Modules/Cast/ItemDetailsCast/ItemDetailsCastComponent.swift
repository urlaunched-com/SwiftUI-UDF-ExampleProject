//
//  ItemDetailsCastComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF

struct ItemDetailsCastComponent: Component {
    struct Props {
        var cast: [Cast.ID]
        var castById: (Cast.ID) -> Cast
        var isRedacted: Bool
        var router: Router<ItemDetailsCastRouting> = .init()
    }

    var props: Props

    @Environment(\.width) private var componentWidth
    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        if props.cast.isNotEmpty {
            VStack(alignment: .leading, spacing: 21) {
                SectionHeaderView(
                    title: Localization.itemDetailsCastSectionTitle(),
                    seeAllAction: {
                        globalRouter.navigate(to: .cast(props.cast), with: props.router)
                    }
                )

                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        let width = abs(componentWidth - 64) / 3
                        let height = width * 1.25
                        ForEach(props.cast, id: \.self) { id in
                            CastCardView(
                                cast: props.castById(id),
                                size: .init(width: width, height: height),
                                lineLimit: 1
                            )
                            .frame(width: width)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
            .isRedacted(props.isRedacted)
            .disabled(props.isRedacted)
        }
    }
}

// MARK: - Preview

#Preview {
    ItemDetailsCastComponent(
        props: .init(
            cast: [],
            castById: { _ in .fakeItem() },
            isRedacted: false
        )
    )
}
