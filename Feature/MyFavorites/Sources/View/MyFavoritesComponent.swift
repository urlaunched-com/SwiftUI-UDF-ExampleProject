//
//  MyFavoritesComponent.swift
//  Flick
//
//  Created by Vlad Andrieiev on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF
import Common
import CustomViews
import MediaModels

struct MyFavoritesComponent<R: Routing>: Component where R.Route == MyFavoritesRoute {
    struct Props {
        var contentType: Binding<ContentType>
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var loadMoreAction: Command
        var isRedacted: Bool
        var dialog: Binding<DialogStatus>
        var router: Router<R>

        init(
            contentType: Binding<ContentType>,
            items: [any Item],
            genreById: @escaping (Genre.ID) -> Genre?,
            loadMoreAction: @escaping Command,
            isRedacted: Bool,
            dialog: Binding<DialogStatus>,
            router: Router<R> = .init()
        ) {
            self.contentType = contentType
            self.items = items
            self.genreById = genreById
            self.loadMoreAction = loadMoreAction
            self.isRedacted = isRedacted
            self.dialog = dialog
            self.router = router
        }
    }

    var props: Props

    init(props: Props) {
        self.props = props
    }

    var body: some View {
        SelectiveItemsList(
            items: props.items,
            genreById: props.genreById,
            loadMoreAction: props.loadMoreAction,
            isRedacted: props.isRedacted,
            header: {
                ContentToggle(contentType: props.contentType)
            },
            imageView: { path in
                props.router.view(
                    for: .imageContainer(
                        path: path,
                        size: ItemSizeStyle.default.coverSize,
                        type: .poster
                    )
                )
            }
        )
        .customNavigationTitle(Localization.myFavoritesNavigationTitle())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image.filter
                        .aspectFit()
                        .frame(20)
                }
            }
        }
        .dialog(status: props.dialog)
    }
}

#Preview {
    MyFavoritesComponent(
        props: .init(
            contentType: .constant(.movie),
            items: Movie.testItems(count: 10),
            genreById: { _ in .testItem() },
            loadMoreAction: {},
            isRedacted: true,
            dialog: .constant(.dismissed),
            router: .init(routing: MockedRouting<MyFavoritesRoute>())
        )
    )
}
