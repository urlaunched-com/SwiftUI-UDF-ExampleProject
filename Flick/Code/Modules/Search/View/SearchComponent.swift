//
//  SearchComponent.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 22.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Combine
import DesignSystem
import Localizations
import SwiftUI
import UDF

struct SearchComponent: Component {
    struct Props {
        var searchText: Binding<String>
        var itemIds: [SearchItem.ID]
        var searchItemById: (SearchItem.ID) -> SearchItem
        var genreById: (Genre.ID) -> Genre
        var loadMoreAction: Command
    }

    var props: Props

    @FocusState private var focusedField: Field?

    var body: some View {
        VStack(spacing: 16) {
            searchTextField
                .padding(.horizontal)

            List {
                ForEach(props.itemIds, id: \.self) { id in
                    let item = props.searchItemById(id)
                    searchRow(item: item)
                        .listRowBackground(Color.flMain)
                        .listRowSeparator(.hidden)
                        .frame(maxHeight: 189)
                        .onAppear {
                            if id == props.itemIds.last {
                                props.loadMoreAction()
                            }
                        }
                }
            }
            .listStyle(.plain)
            .overlay {
                placeholder()
            }
        }
        .background(Color.flMain)
        .background(ignoresSafeAreaEdges: .all)
        .customNavigationTitle(Localization.searchNavigationTitle())
        .onTapGesture {
            focusedField = .none
        }
        .hideKeyboardByTap()
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
    }
}

// MARK: - SearchTextField

private extension SearchComponent {
    enum Field {
        case search
    }

    var searchTextField: some View {
        SearchTextField(
            placeholder: Localization.searchSearchPlaceholder(),
            text: props.searchText,
            textFieldId: Field.search,
            isFocused: $focusedField
        )
        .onTapGesture {
            focusedField = .search
        }
    }
}

// MARK: - SearchRow

private extension SearchComponent {
    func searchRow(item: SearchItem) -> some View {
        HStack(spacing: 16) {
            PosterImageView(
                posterPath: item.posterPath, year: item.year, rating: item.rating
            )
            .overlay(alignment: .topLeading) {
                heartButton
            }
            VStack(alignment: .leading) {
                rowTexts(
                    title: item.theTitle,
                    genres: item.genres(action: props.genreById),
                    overview: item.overview
                )
                Spacer()
                forwardButton
            }
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
        .buttonStyle(.circle(fillColor: .flPink10))
        .padding(8)
    }

    var forwardButton: some View {
        Button(action: {}) {
            Image.logoutRight
                .aspectFit()
                .frame(20)
        }
        .buttonStyle(.circle(fillColor: .flPink10))
    }
}

// MARK: - SearchPlaceholder

private extension SearchComponent {
    @ViewBuilder
    func placeholder() -> some View {
        if props.itemIds.isEmpty {
            searchPlaceholder
        } else {
            Color.clear
        }
    }

    var searchPlaceholder: some View {
        VStack(spacing: 33) {
            Spacer()
            Image
                .search
                .template
                .aspectFit()
                .frame(73)
                .foregroundStyle(.flPurpleLight)
            Text(
                props.searchText.wrappedValue.isEmpty
                    ? Localization.searchListPlaceholder()
                    : Localization.searchNoResultsPlaceholder()
            )
            .foregroundStyle(.flPurpleLight)
            .customFont(.subheadline)
            Spacer()
        }
    }
}

// MARK: - Preview

#Preview("Search Results") {
    SearchComponent(
        props: .init(
            searchText: .constant("Search text"),
            itemIds: SearchItem.testItems(count: 10).ids,
            searchItemById: { _ in .fakeItem() },
            genreById: { _ in .testItem() },
            loadMoreAction: {}
        )
    )
}

#Preview("Empty Search") {
    SearchComponent(
        props: .init(
            searchText: .constant("g"),
            itemIds: [],
            searchItemById: { _ in .fakeItem() },
            genreById: { _ in .testItem() },
            loadMoreAction: {}
        )
    )
}
