//
//  CastComponent.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF
import Models
import Common
import CustomViews

struct CastComponent<R: Routing<CastRoute>>: Component {
    struct Props {
        var cast: [Models.Cast.ID]
        var castById: (Models.Cast.ID) -> Models.Cast
        var dialogStatus: Binding<DialogStatus>
        var router: Router<R>

        init(
            cast: [Models.Cast.ID],
            castById: @escaping (Models.Cast.ID) -> Models.Cast,
            dialogStatus: Binding<DialogStatus>,
            router: Router<R> = .init()
        ) {
            self.cast = cast
            self.castById = castById
            self.dialogStatus = dialogStatus
            self.router = router
        }
    }

    var props: Props

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), spacing: 16, alignment: .top),
        GridItem(.flexible(), alignment: .top),
    ]

    init(props: Props) {
        self.props = props
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    let width = abs(geometry.size.width - 64) / 3
                    let height = width * 1.25
                    ForEach(props.cast, id: \.value) { id in
                        let cast = props.castById(id)
                        let size = CGSize(width: width, height: height)
                        CastCardView(
                            cast: cast,
                            size: size,
                            imageView: {
                                props.router.view(
                                    for: .imageContainer(
                                        path: cast.profilePath,
                                        size: size,
                                        type: .profile
                                    )
                                )
                            }
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
        .dialog(status: props.dialogStatus)
    }
}

#Preview {
    CastComponent(
        props: .init(
            cast: [],
            castById: { _ in .fakeItem() },
            dialogStatus: .constant(.dismissed),
            router: .init(routing: MockRouter<CastRoute>())
        )
    )
}
