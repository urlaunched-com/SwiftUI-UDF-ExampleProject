//
//  SectionDetailsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import SwiftUI_Kit
import UDF

struct SectionDetailsComponent: Component {
    struct Props {
        var title: String
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var loadMoreAction: Command
        var alertStatus: Binding<AlertBuilder.AlertStatus>
        var router: Router<SectionDetailsRouting> = .init()
    }

    var props: Props

    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        GeometryReader { geometry in
            List(props.items.indices, id: \.self) { index in
                let item = props.items[index]
                SectionDetailsRow(
                    item: item,
                    genres: item.genres(action: props.genreById),
                    size: .init(width: geometry.size.width, height: geometry.size.height * 0.75),
                    toggleFavoriteAction: {},
                    shareAction: {}
                )
                .onAppear {
                    if index == props.items.indices.last {
                        props.loadMoreAction()
                    }
                }
                .embedInPlainButton {
                    globalRouter.navigate(to: .itemDetails(item), with: props.router)
                }
                .listRowInsets(.zero)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .background(Color.flMain)
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(props.title)
                        .customFont(.headline)
                        .foregroundStyle(.flText)
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .alert(status: props.alertStatus)
        }
    }
}

// MARK: - Preview

#Preview {
    SectionDetailsComponent(
        props: .init(
            title: "Popular",
            items: Movie.testItems(count: 10),
            genreById: { _ in .fakeItem() },
            loadMoreAction: {},
            alertStatus: .constant(.dismissed)
        )
    )
}
