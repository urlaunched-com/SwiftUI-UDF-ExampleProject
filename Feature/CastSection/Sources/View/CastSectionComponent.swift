//
//  CastSectionComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 19.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF
import Models
import CustomViews
import Common

public struct CastSectionComponent<R: Routing<CastSectionRoute>>: Component {
    public struct Props {
        var cast: [Cast.ID]
        var castById: (Cast.ID) -> Cast
        var isRedacted: Bool
        var router: Router<R> = .init()
        
        public init(
            cast: [Cast.ID],
            castById: @escaping (Cast.ID) -> Cast,
            isRedacted: Bool,
            router: Router<R> = .init(),
        ) {
            self.cast = cast
            self.castById = castById
            self.isRedacted = isRedacted
            self.router = router
        }
    }

    public var props: Props
    
    public init(props: Props) {
        self.props = props
    }

    @Environment(\.width) private var componentWidth
    @Environment(\.globalRouter) private var globalRouter

    public var body: some View {
        if props.cast.isNotEmpty {
            VStack(alignment: .leading, spacing: 21) {
                SectionHeaderView(
                    title: Localization.itemDetailsCastSectionTitle(),
                    seeAllAction: {
                        globalRouter.navigate(for: R.self, to: .cast(props.cast))
                    }
                )

                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        let width = abs(componentWidth - 64) / 3
                        let height = width * 1.25
                        let size = CGSize(
                            width: width,
                            height: height
                        )
                        ForEach(props.cast, id: \.self) { id in
                            let cast = props.castById(id)
                            CastCardView(
                                cast: props.castById(id),
                                size: size,
                                imageView: {
                                    props.router.view(
                                        for: .imageContainer(
                                            path: cast.profilePath,
                                            size: size,
                                            type: .profile
                                        )
                                    )
                                },
                                lineLimit: 1,
                            )
                            .frame(width: width)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
            .isRedacted(props.isRedacted)
            .disabled(props.isRedacted)
        }
    }
}

// MARK: - Preview

#Preview {
    CastSectionComponent(
        props: .init(
            cast: [],
            castById: { _ in .fakeItem() },
            isRedacted: false,
            router: .init(routing: MockRouter())
        )
    )
}
