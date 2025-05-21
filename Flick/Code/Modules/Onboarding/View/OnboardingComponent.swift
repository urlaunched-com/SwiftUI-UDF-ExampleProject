//
//  OnboardingComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 11.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import SwiftUI_Kit
import UDF

struct OnboardingComponent: Component {
    struct Props {
        let skipAction: Command
    }

    var props: Props
    @State private var page: any Pageable

    init(props: Props) {
        self.props = props
        _page = .init(initialValue: Page.first)
    }

    init(props: Props, page: some Pageable) {
        self.props = props
        _page = .init(initialValue: page)
    }

    var body: some View {
        ZStack {
            page.color
            GeometryReader {
                let height = $0.size.height
                ZStack {
                    pageImageView(imageHeight: height * 0.6)
                    VStack {
                        Spacer()
                        ZStack {
                            RoundedCorner(radius: 117, corners: [.topLeft])
                                .fill(LinearGradient.primaryBackground)
                                .ignoresSafeArea()
                            VStack {
                                PageIndicator(
                                    pages: Page.allPages,
                                    selectedPage: page
                                )
                                .padding(.top, 26)

                                Text(page.title)
                                    .customFont(.title)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 38)
                                    .foregroundStyle(.flText)
                                    .frame(minHeight: height * 0.2)
                                pageButtons
                                Spacer()
                            }
                        }
                        .frame(height: height * 0.4)
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

// MARK: - Views

extension OnboardingComponent {
    func pageImageView(imageHeight: CGFloat) -> some View {
        ZStack {
            page.color
            VStack {
                page.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: imageHeight)
                Spacer()
            }
        }
        .id(page.id)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }

    @ViewBuilder
    var pageButtons: some View {
        if page.nextPage == nil {
            Button(action: props.skipAction) {
                Text(Localization.onboardingGetStartedButtonTitle())
                    .customFont(.title3)
                    .foregroundStyle(.flWhite)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.primary())
            .padding(.horizontal)
        } else {
            HStack {
                Button(Localization.onboardingSkipButtonTitle(), action: props.skipAction)
                    .buttonStyle(.plain)
                    .foregroundStyle(.flGray)
                Spacer()
                Button(action: selectNextPage) {
                    Image
                        .logoutRight
                        .renderingMode(.template)
                        .foregroundStyle(page.color)
                }
                .buttonStyle(.circle(fillColor: page.color.opacity(0.1)))
            }
            .padding(.horizontal, 38)
        }
    }

    func selectNextPage() {
        withAnimation(.spring()) {
            if let nextPage = page.nextPage {
                page = nextPage
            } else {
                props.skipAction()
            }
        }
    }
}

// MARK: - PageIndicator

extension OnboardingComponent {
    struct PageIndicator: View {
        var pages: [any Pageable]
        var selectedPage: any Pageable

        var body: some View {
            HStack {
                ForEach(pages, id: \.id) { page in
                    Capsule()
                        .fill(page.id == selectedPage.id ? page.color : .flPurpleLight)
                        .frame(width: page.id == selectedPage.id ? 47 : 7, height: 7)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    OnboardingComponent(
        props: .init(
            skipAction: {}
        )
    )
}
