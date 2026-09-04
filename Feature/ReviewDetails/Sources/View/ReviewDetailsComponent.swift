//
//  ReviewDetailsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF
import Models
import CustomViews
import Common

public struct ReviewDetailsComponent<R: Routing>: Component where R.Route == ReviewDetailsRoute {
    public struct Props {
        var id: Review.ID
        var reviewByID: (Review.ID) -> Review
        var isRedacted: Bool
        var dialog: Binding<DialogStatus>
        var router: Router<R>
        
        public init(
            id: Review.ID,
            reviewByID: @escaping (Review.ID) -> Review,
            isRedacted: Bool,
            dialog: Binding<DialogStatus>,
            router: Router<R> = .init()
        ) {
            self.id = id
            self.reviewByID = reviewByID
            self.isRedacted = isRedacted
            self.dialog = dialog
            self.router = router
        }
    }
    
    public init(props: Props) {
        self.props = props
    }

    public var props: Props

    public var body: some View {
        ScrollView {
            let review = props.reviewByID(props.id)
            VStack(alignment: .leading, spacing: 16) {
                ReviewHeaderView(
                    review: review,
                    placeholderColor: .flSecondary,
                    imageView: props.router.view(
                        for: .imageContainer(
                            path: review.authorDetails.avatarPath,
                            size: CGSize(width: 48, height: 48),
                            type: .profile
                        )
                    )
                )
                .padding(.horizontal, 10)
                
                Text(review.content)
                    .customFont(.body)
                    .foregroundStyle(.flText)
            }
            .padding()
        }
        .dialog(status: props.dialog)
        .redacted(reason: props.isRedacted ? .placeholder : [])
        .customNavigationTitle(Localization.itemDetailsReviewsNavigationTitle())
        .background(Color.flMain.edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Preview

#Preview {
    ReviewDetailsComponent(
        props: .init(
            id: Review.fakeItem().id,
            reviewByID: { _ in Review.fakeItem() },
            isRedacted: false,
            dialog: .constant(.dismissed),
            router: .init(routing: MockRouter())
        )
    )
}
