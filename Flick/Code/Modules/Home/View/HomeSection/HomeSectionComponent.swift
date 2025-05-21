//
//  HomeSectionComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 30.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import UDF

struct HomeSectionComponent<S: Section>: Component {
    struct Props {
        var section: S
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var router: Router<HomeRouting> = .init()
    }

    var props: Props

    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        VStack(spacing: 24) {
            SectionHeaderView(
                title: props.section.title,
                seeAllAction: {
                    globalRouter.navigate(to: .sectionDetails(props.section), with: props.router)
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
                            globalRouter.navigate(to: .itemDetails(item), with: props.router)
                        }
                        .buttonStyle(.scaled)
                    }
                }
            }
        }
        .frame(height: 340, alignment: .top)
    }
}

// MARK: - Preview

#Preview {
    HomeSectionComponent(
        props: .init(
            section: MovieSection.nowPlaying,
            items: [],
            genreById: { _ in .fakeItem() }
        )
    )
}
