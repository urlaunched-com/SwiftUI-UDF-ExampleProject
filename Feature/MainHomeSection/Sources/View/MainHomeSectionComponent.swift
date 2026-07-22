//
//  MainHomeSectionComponent.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import SwiftUI_Kit
import UDF
import Models
import Common
import CustomViews

public struct MainHomeSectionComponent<S: Models.Section, R: Routing>: Component where R.Route == MainHomeSectionRoute {
    public struct Props {
        var section: S
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var router: R

        public init(
            section: S,
            items: [any Item],
            genreById: @escaping (Genre.ID) -> Genre?,
            router: R
        ) {
            self.section = section
            self.items = items
            self.genreById = genreById
            self.router = router
        }
    }

    public var props: Props

    public init(props: Props) {
        self.props = props
    }

    @Environment(\.globalRouter) private var globalRouter

    public var body: some View {
        VStack(spacing: 10) {
            SectionHeaderView(
                title: props.section.title,
                seeAllAction: {
                    globalRouter.navigate(for: R.self, to: .sectionDetails(props.section))
                }
            )
            .padding(.bottom)

            MainSectionScrollView(
                items: props.items,
                genresByItem: { $0.genres(action: props.genreById) },
                navigateToItemDetails: { item in
                    globalRouter.navigate(for: R.self, to: .itemDetails(item))
                },
                backgroundImage: { size, path in
                    props.router.view(
                        for: .imageContainer(
                            path: path,
                            size: size,
                            type: .backdrop,
                            isLoaderPresented: true
                        )
                    )
                },
                cardImage: { item in
                    props.router.view(
                        for: .imageContainer(
                            path: item.posterPath,
                            size: ItemSizeStyle.default.coverSize,
                            type: .poster,
                            isLoaderPresented: false
                        )
                    )
                }
            )
        }
        .clipShape(RoundedCorner(radius: 50, corners: [.bottomLeft, .bottomRight]))
        .frame(height: 460)
    }
}
