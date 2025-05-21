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

struct MyFavoritesComponent: Component {
    struct Props {
        var contentType: Binding<ContentType>
        var items: [any Item]
        var genreById: (Genre.ID) -> Genre?
        var loadMoreAction: Command
        var isRedacted: Bool
        var alertStatus: Binding<AlertBuilder.AlertStatus>
    }

    var props: Props

    var body: some View {
        SelectiveItemsList(items: props.items, genreById: props.genreById, loadMoreAction: props.loadMoreAction, isRedacted: props.isRedacted) {
            ContentToggle(contentType: props.contentType)
        }
        .customNavigationTitle(Localization.myFavoritesNavigationTitle())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image.filter
                        .aspectFit()
                        .frame(24)
                }
            }
        }
        .alert(status: props.alertStatus)
    }
}

// MARK: - Preview

#Preview {
    MyFavoritesComponent(
        props: .init(
            contentType: .constant(.movie),
            items: Movie.testItems(count: 10),
            genreById: { _ in .testItem() },
            loadMoreAction: {},
            isRedacted: true,
            alertStatus: .constant(.dismissed)
        )
    )
}
