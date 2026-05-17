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
import Models
import UIKit
import Common
import CustomViews

public struct CastComponent<R: Routing>: Component where R.Route == CastRoute {
    public struct Props {
        var cast: [Cast.ID]
        var castById: (Cast.ID) -> Cast
        var dialogStatus: Binding<DialogStatus>
        var router: R = .init()
        var destinationBuilder: DestinationBuilder<CastContent> = .init()
        
        public init(
            cast: [Cast.ID],
            castById: @escaping (Cast.ID) -> Cast,
            dialogStatus: Binding<DialogStatus>,
            router: R = .init(),
            destinationBuilder: DestinationBuilder<CastContent> = .init()
        ) {
            self.cast = cast
            self.castById = castById
            self.dialogStatus = dialogStatus
            self.router = router
            self.destinationBuilder = destinationBuilder
        }
    }

    public var props: Props

    let columns: [GridItem] = [GridItem(.flexible(), spacing: 16, alignment: .top),
                               GridItem(.flexible(), spacing: 16, alignment: .top),
                               GridItem(.flexible(), alignment: .top)]

    public init(props: Props) {
        self.props = props
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    let width = abs(geometry.size.width - 64) / 3
                    let height = width * 1.25
                    ForEach(props.cast, id: \.value) { id in
                        let cast = props.castById(id)
                        let size = CGSize(
                            width: width,
                            height: height
                        )
                        CastCardView(
                            cast: cast,
                            size: size,
                            imageView: {
                                props.destinationBuilder.view(
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

// MARK: - Preview

#Preview {
    CastComponent(
        props: .init(
            cast: [],
            castById: { _ in .fakeItem() },
            dialogStatus: .constant(.dismissed),
            router: MockRouter<CastRoute>()
        )
    )
}
