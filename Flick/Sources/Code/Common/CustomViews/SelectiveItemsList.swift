//
//  SelectiveItemsList.swift
//  Flick
//
//  Created by Vlad Andrieiev on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct SelectiveItemsList<Header: View>: View {
    var items: [any Item]
    var genreById: (Genre.ID) -> Genre?
    var loadMoreAction: Command
    var isRedacted: Bool
    var header: () -> Header

    init(
        items: [any Item],
        genreById: @escaping (Genre.ID) -> Genre?,
        loadMoreAction: @escaping Command,
        isRedacted: Bool,
        @ViewBuilder header: @escaping () -> Header
    ) {
        self.items = items
        self.genreById = genreById
        self.loadMoreAction = loadMoreAction
        self.isRedacted = isRedacted
        self.header = header
    }

    var body: some View {
        List {
            Group {
                header()
                    .listRowInsets(.init(.zero))
                ForEach(items.indices, id: \.self) { index in
                    itemRow(item: items[index])
                        .frame(maxHeight: 189)
                        .onAppear {
                            if index == items.indices.last {
                                loadMoreAction()
                            }
                        }
                }
            }
            .listRowBackground(Color.flMain)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .isRedacted(isRedacted)
    }
}

// MARK: - itemRow

private extension SelectiveItemsList {
    func itemRow(item: any Item) -> some View {
        HStack(spacing: 16) {
            PosterImageView(
                posterPath: item.posterPath,
                year: item.year,
                rating: item.rating
            )
            .overlay(alignment: .topLeading) {
                heartButton
                    .padding(8)
            }
            VStack(alignment: .leading) {
                rowTexts(
                    title: item.title,
                    genres: item.genres(action: genreById),
                    overview: item.overview
                )
                Spacer()
                forwardButton
            }
            Spacer()
        }
    }

    func rowTexts(title: String, genres: String, overview: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .customFont(.headline)
                .foregroundStyle(.flText)
                .lineLimit(3)
                .fixedHeight()
            Text(genres)
                .customFont(.caption2)
                .foregroundStyle(.flPurpleLight)
            Text(overview)
                .customFont(.caption)
                .foregroundStyle(.flGray)
                .lineLimit(2)
        }
        .multilineTextAlignment(.leading)
    }

    var heartButton: some View {
        Button(action: {}) {
            Image.heartNormal
                .aspectFit()
                .frame(20)
        }
        .buttonStyle(.circle(padding: 8))
    }

    var forwardButton: some View {
        Button(action: {}) {
            Image.logoutRight
                .aspectFit()
                .frame(24)
        }
        .buttonStyle(.circle(padding: 8))
    }
}

// MARK: - Preview

#Preview {
    SelectiveItemsList(
        items: Movie.testItems(count: 10),
        genreById: { _ in .testItem() },
        loadMoreAction: {},
        isRedacted: true,
        header: { EmptyView() }
    )
}
