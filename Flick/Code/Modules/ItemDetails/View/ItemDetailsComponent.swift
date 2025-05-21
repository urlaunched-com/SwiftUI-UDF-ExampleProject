//
//  ItemDetailsComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 17.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import SwiftUI_Kit
import UDF

struct ItemDetailsComponent: Component {
    struct Props {
        var item: any Item
        var genreById: (Genre.ID) -> Genre?
        var alert: Binding<AlertBuilder.AlertStatus>
        var router: Router<ItemDetailsRouting> = .init()
    }

    var props: Props
    @State private var imageScale: CGFloat = 1

    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .top) {
                    let imageHeight = geometry.size.height * 0.7
                    ImageContainer(
                        size: .init(width: geometry.size.width, height: imageHeight),
                        path: props.item.posterPath
                    )
                    .frame(width: geometry.size.width, height: imageHeight)
                    .clipped()
                    .scaleEffect(imageScale, anchor: .bottom)

                    VStack(spacing: 0) {
                        offsetReaderView(globalMinY: geometry.frame(in: .global).minY)
                        mainButtons(height: abs(imageHeight - 40))
                        VStack(spacing: 0) {
                            mainInfoView
                            secondaryInfoView

                            VStack(spacing: 4) {
                                props.router.view(for: .cast(props.item))
                                    .width(geometry.size.width)
                                props.router.view(for: .reviews(props.item))
                                props.router.view(for: .recommendations(props.item))
                            }
                        }
                        .background(Color.flMain.cornerRadius(36, corners: [.topLeft, .topRight]))
                    }
                    .padding(.bottom)
                }
            }
            .background(Color.flMain.ignoresSafeArea(.all))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // TODO: - Add action later
                Button(action: {}) {
                    HStack(spacing: 6) {
                        Text(Localization.itemDetailsTrailerButtonTitle())
                            .customFont(.subheadline)
                        Image.playCircle
                            .template
                            .aspectFit()
                            .frame(20)
                    }
                    .foregroundStyle(.flMainPink)
                }
            }
        }
        .alert(status: props.alert)
    }
}

private extension ItemDetailsComponent {
    func offsetReaderView(globalMinY: CGFloat) -> some View {
        Color.clear
            .frame(height: 1)
            .background(
                GeometryReader { geometry in
                    let localMinY = geometry.frame(in: .global).minY
                    Color.clear
                        .preference(
                            key: OffsetPreferenceKey.self,
                            value: globalMinY - localMinY
                        )
                        .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                            if offset < 0 {
                                imageScale = 1 + abs(offset * 0.002)
                            }
                        }
                }
            )
    }

    func mainButtons(height: CGFloat) -> some View {
        VStack(spacing: 24) {
            HStack(spacing: 20) {
                // TODO: - Add action later
                Button(action: {}) {
                    Image.starNormal
                        .aspectFit()
                        .frame(30)
                }
                .buttonStyle(.circle())
                // TODO: - Add action later
                Button(action: {}) {
                    Image.heartNormal
                        .aspectFit()
                        .frame(30)
                }
                .buttonStyle(.circle())
                // TODO: - Add action later
                Button(action: {}) {
                    Image.logoutRight
                        .aspectFit()
                        .frame(30)
                }
                .buttonStyle(.circle())
            }
            .padding(.bottom, 24)
            .frame(height: height, alignment: .bottom)
        }
    }

    var mainInfoView: some View {
        VStack(spacing: 8) {
            Group {
                Text(props.item.year) +
                    Text(props.item.year.isEmpty || props.item.durationText.isEmpty ? "" : "  |  ") +
                    Text(props.item.durationText)
            }
            .foregroundStyle(.flPurpleLight)
            .lineLimit(1)

            Text(props.item.title)
                .customFont(.title)
                .fixedHeight()

            if !props.item.genreIds.isEmpty {
                Text(props.item.genres(action: props.genreById))
                    .foregroundStyle(.flPurpleLight)
                    .fixedHeight()
            }

            HStack(spacing: 10) {
                if props.item.rating > 0 {
                    RatingCircle(
                        value: "\(props.item.rating)%",
                        strokeColor: props.item.ratingColor
                    )
                }

                Text(Localization.itemDetailsWhereToWatchButtonTitle())
                    .customFont(.title3)
                    .foregroundStyle(.flWhite)
                    .frame(maxWidth: .infinity)
                    .embedInPlainButton {
                        // TODO: - Add action later ???
                        globalRouter.navigate(to: .whereToWatch(props.item), with: props.router)
                    }
                    .buttonStyle(PrimaryButtonStyle(fillColor: .flMainPink))
            }
            .padding(.top, 16)
            .padding(.bottom, 8)

            Text(props.item.overview)
                .fixedHeight()
                .multilineTextAlignment(.leading)

            Color.flSecondary
                .frame(height: 1)
                .padding(.top, 8)
        }
        .customFont(.body)
        .foregroundStyle(.flText)
        .multilineTextAlignment(.center)
        .padding()
        .frame(maxWidth: .infinity)
    }

    var secondaryInfoView: some View {
        VStack(spacing: 18) {
            HStack(spacing: 0) {
                secondaryInfoRow(
                    image: .videoPlay,
                    title: Localization.itemDetailsStatusSectionTitle(),
                    value: props.item.statusText
                )
                secondaryInfoRow(
                    image: .global,
                    title: Localization.itemDetailsLanguageSectionTitle(),
                    value: props.item.language
                )
            }
            .padding(.bottom, 2)
            if let movie = props.item as? Movie {
                HStack(spacing: 0) {
                    secondaryInfoRow(
                        image: .moneySend,
                        title: Localization.itemDetailsBudgetSectionTitle(),
                        value: movie.budget.asAmountOfMoney
                    )
                    secondaryInfoRow(
                        image: .moneyRecieve,
                        title: Localization.itemDetailsRevenueSectionTitle(),
                        value: movie.revenue.asAmountOfMoney
                    )
                }
            } else if let show = props.item as? Show {
                HStack(spacing: 0) {
                    secondaryInfoRow(
                        image: .camera,
                        title: Localization.itemDetailsNetworkSectionTitle(),
                        value: show.networks.first?.name ?? "-"
                    )
                    secondaryInfoRow(
                        image: .subtitle,
                        title: Localization.itemDetailsTypeSectionTitle(),
                        value: show.typeText
                    )
                }
            }

            Color.flSecondary
                .frame(height: 1)
        }
        .padding(.horizontal)
    }

    func secondaryInfoRow(image: Image, title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                image
                    .template
                    .aspectFit()
                    .frame(17)
                Text(title)
            }
            .foregroundStyle(.flPurpleLight)

            Text(value)
                .foregroundStyle(.flGray)
        }
        .customFont(.body)
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

#Preview {
    ItemDetailsComponent(
        props: .init(
            item: Movie.fakeItem(),
            genreById: { _ in .fakeItem() },
            alert: .constant(.dismissed)
        )
    )
    .embedInNavigationStack()
}
