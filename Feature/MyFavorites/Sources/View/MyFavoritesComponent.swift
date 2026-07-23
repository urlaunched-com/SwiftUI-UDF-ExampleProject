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
import Models
import Common
import CustomViews

public struct MyFavoritesComponent<R: Routing>: Component where R.Route == MyFavoritesRoute {
    public struct Props {
        var contentType: Binding<ContentType>
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var loadMoreAction: Command
        var isRedacted: Bool
        var dialogStatus: Binding<DialogStatus>
        var router: R

        public init(
            contentType: Binding<ContentType>,
            items: [any Item],
            genreById: @escaping (Genre.ID) -> Genre?,
            loadMoreAction: @escaping Command,
            isRedacted: Bool,
            dialogStatus: Binding<DialogStatus>,
            router: R
        ) {
            self.contentType = contentType
            self.items = items
            self.genreById = genreById
            self.loadMoreAction = loadMoreAction
            self.isRedacted = isRedacted
            self.dialogStatus = dialogStatus
            self.router = router
        }
    }

    public var props: Props

    public init(props: Props) {
        self.props = props
    }

    public var body: some View {
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
        .dialog(status: props.dialogStatus)
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
            dialogStatus: .constant(.dismissed),
            router: MockRouter<MyFavoritesRoute>()
        )
    )
}
