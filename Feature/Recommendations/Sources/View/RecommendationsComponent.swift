//
//  RecommendationsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 05.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import SwiftUI_Kit
import UDF
import Models
import Common
import CustomViews

public struct RecommendationsComponent<R: Routing>: Component where R.Route == RecommendationsRoute {
    public struct Props {
        var title: String
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var loadMoreAction: Command
        var dialog: Binding<DialogStatus>
        var router: Router<R> = .init()
        
        public init(
            title: String,
            items: [any Item],
            genreById: @escaping (Genre.ID) -> Genre?,
            loadMoreAction: @escaping Command,
            dialog: Binding<DialogStatus>,
            router: Router<R> = .init()
        ) {
            self.title = title
            self.items = items
            self.genreById = genreById
            self.loadMoreAction = loadMoreAction
            self.dialog = dialog
            self.router = router
        }
    }

    public var props: Props
    
    public init(props: Props) {
        self.props = props
    }

    @Environment(\.globalRouter) private var globalRouter

    public var body: some View {
        GeometryReader { geometry in
            List(props.items.indices, id: \.self) { index in
                let item = props.items[index]
                let size = CGSize(width: geometry.size.width, height: geometry.size.height * 0.75)
                SectionDetailsRow(
                    item: item,
                    genres: item.genres(action: props.genreById),
                    size: .init(width: geometry.size.width, height: geometry.size.height * 0.75),
                    toggleFavoriteAction: {},
                    shareAction: {},
                    imageView: props.router.view(for: .imageContainer(path: item.posterPath, size: size))
                )
                .onAppear {
                    if index == props.items.indices.last {
                        props.loadMoreAction()
                    }
                }
                .embedInPlainButton {
                    globalRouter.navigate(for: R.self, to: .itemDetails(item))
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
            .dialog(status: props.dialog)
        }
    }
}

// MARK: - Preview

#Preview {
    RecommendationsComponent(
        props: .init(
            title: "Popular",
            items: Movie.testItems(count: 10),
            genreById: { _ in .fakeItem() },
            loadMoreAction: {},
            dialog: .constant(.dismissed),
            router: .init(routing: MockRouter())
        )
    )
}
