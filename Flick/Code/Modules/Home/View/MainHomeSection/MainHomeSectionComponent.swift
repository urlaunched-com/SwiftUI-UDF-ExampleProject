//
//  MainHomeSectionComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import SwiftUI_Kit
import UDF

struct MainHomeSectionComponent<S: Section>: Component {
    struct Props {
        var section: S
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var router: Router<MainHomeSectionRouting> = .init()
    }

    var props: Props

    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        VStack(spacing: 10) {
            SectionHeaderView(
                title: props.section.title,
                seeAllAction: {
                    globalRouter.navigate(to: .sectionDetails(props.section), with: props.router)
                }
            )
            .padding(.bottom)

            MainSectionScrollView(
                items: props.items,
                genresByItem: { $0.genres(action: props.genreById) },
                navigateToItemDetails: { item in
                    globalRouter.navigate(to: .itemDetails(item), with: props.router)
                }
            )
        }
        .clipShape(RoundedCorner(radius: 50, corners: [.bottomLeft, .bottomRight]))
        .frame(height: 460)
    }
}
