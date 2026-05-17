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
import Common
import CustomViews
import Models

public struct HomeSectionComponent<S: Models.Section, R: Routing>: Component where R.Route == HomeSectionRoute {
    public struct Props {
        var section: S
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var router: R = .init()
        var destinationBuilder: DestinationBuilder<HomeContent> = .init()
        
        public init(
            section: S,
            items: [any Item],
            genreById: @escaping (Genre.ID) -> Genre?,
            router: R = .init(),
            destinationBuilder: DestinationBuilder<HomeContent> = .init()
        ) {
            self.section = section
            self.items = items
            self.genreById = genreById
            self.router = router
            self.destinationBuilder = destinationBuilder
        }
    }

    public var props: Props

    @Environment(\.globalRouter) private var globalRouter
    
    public init(props: Props) {
        self.props = props
    }

    public var body: some View {
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
                            imageView: props.destinationBuilder.view(
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

// MARK: - Preview

#Preview {
    HomeSectionComponent(
        props: .init(
            section: MovieSection.nowPlaying,
            items: [],
            genreById: { _ in .fakeItem() },
            router: MockRouter<HomeSectionRoute>()
        )
    )
}
