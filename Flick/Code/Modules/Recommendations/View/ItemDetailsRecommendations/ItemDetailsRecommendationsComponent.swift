//
//  ItemDetailsRecommendationsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 05.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF

struct ItemDetailsRecommendationsComponent: Component {
    struct Props {
        var item: any Item
        var items: [any Item]
        var isRedacted: Bool
        var genreById: (Genre.ID) -> Genre?
        var router: Router<ItemDetailsRecommendationsRouting> = .init()
    }

    var props: Props

    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        if !props.items.isEmpty {
            VStack(alignment: .leading, spacing: 24) {
                SectionHeaderView(
                    title: Localization.itemDetailsRecommendationsSectionTitle(),
                    seeAllAction: {
                        globalRouter.navigate(for: ItemDetailsRecommendationsRouting.self, to: .recommendations(props.item))
                    }
                )

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 16) {
                        ForEach(props.items.indices, id: \.self) { index in
                            let item = props.items[index]
                            HomeCardView(
                                item: item,
                                genres: item.genres(action: props.genreById)
                            )
                            .padding(.leading, index == props.items.indices.first ? 16 : 0)
                            .padding(.trailing, index == props.items.indices.last ? 16 : 0)
                            .embedInPlainButton {
                                globalRouter.navigate(for: ItemDetailsRecommendationsRouting.self, to: .itemDetails(item))
                            }
                            .buttonStyle(.scaled)
                        }
                    }
                }
            }
            .isRedacted(props.isRedacted)
            .disabled(props.isRedacted)
        }
    }
}

// MARK: - Preview

#Preview {
    ItemDetailsRecommendationsComponent(
        props: .init(
            item: Movie.fakeItem(),
            items: [],
            isRedacted: false,
            genreById: { _ in .fakeItem() }
        )
    )
}
