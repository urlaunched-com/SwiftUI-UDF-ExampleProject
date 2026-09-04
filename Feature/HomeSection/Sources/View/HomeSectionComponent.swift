//
//  HomeSectionComponent.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import DesignSystem
import SwiftUI
import UDF
import Common
import CustomViews
import Models

struct HomeSectionComponent<R: Routing>: Component where R.Route == HomeSectionRoute {
    struct Props {
        var section: any Models.Section
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre
        var router: Router<R>

        init(
            section: any Models.Section,
            items: [any Item],
            genreById: @escaping (Genre.ID) -> Genre,
            router: Router<R> = .init()
        ) {
            self.section = section
            self.items = items
            self.genreById = genreById
            self.router = router
        }
    }

    var props: Props

    @Environment(\.globalRouter) private var globalRouter

    init(props: Props) {
        self.props = props
    }

    var body: some View {
        VStack(spacing: 24) {
            SectionHeaderView(
                title: props.section.title,
                seeAllAction: {
                    globalRouter.navigate(for: R.self, to: .sectionDetails(props.section))
                }
            )

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEach(props.items.indices, id: \.self) { index in
                        let item = props.items[index]
                        HomeCardView(
                            item: item,
                            genres: item.genres(action: props.genreById),
                            imageView: props.router.view(
                                for: .imageContainer(
                                    path: item.posterPath,
                                    size: ItemSizeStyle.default.coverSize,
                                    type: .poster
                                )
                            )
                        )
                        .padding(.leading, index == props.items.indices.first ? 16 : 0)
                        .padding(.trailing, index == props.items.indices.last ? 16 : 0)
                        .embedInPlainButton {
                            globalRouter.navigate(for: R.self, to: .itemDetails(item))
                        }
                        .buttonStyle(.scaled)
                    }
                }
            }
        }
        .frame(height: 340, alignment: .top)
    }
}

#Preview {
    HomeSectionComponent(
        props: .init(
            section: MovieSection.nowPlaying,
            items: [],
            genreById: { _ in .fakeItem() },
            router: .init(routing: MockRouter<HomeSectionRoute>())
        )
    )
}
