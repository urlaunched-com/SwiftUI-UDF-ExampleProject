//
//  CastComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF

struct CastComponent: Component {
    struct Props {
        var cast: [Cast.ID]
        var castById: (Cast.ID) -> Cast
        var alertStatus: Binding<AlertBuilder.AlertStatus>
        var router: Router<ItemDetailsCastRouting> = .init()
    }

    var props: Props

    let columns: [GridItem] = [GridItem(.flexible(), spacing: 16, alignment: .top),
                               GridItem(.flexible(), spacing: 16, alignment: .top),
                               GridItem(.flexible(), alignment: .top)]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    let width = abs(geometry.size.width - 64) / 3
                    let height = width * 1.25
                    ForEach(props.cast, id: \.value) { id in
                        let cast = props.castById(id)
                        CastCardView(
                            cast: cast,
                            size: .init(width: width, height: height)
                        )
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .background(Color.flMain.edgesIgnoringSafeArea(.all))
        .customNavigationTitle(Localization.itemDetailsCastNavigationTitle())
        .alert(status: props.alertStatus)
    }
}

// MARK: - Preview

#Preview {
    CastComponent(
        props: .init(
            cast: [],
            castById: { _ in .fakeItem() },
            alertStatus: .constant(.dismissed)
        )
    )
}
