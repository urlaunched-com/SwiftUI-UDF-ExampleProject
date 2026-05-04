//
//  WhereToWatchComponent.swift
//  Flick
//
//  Created by Arthur Zavolovych on 16.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import FlagKit
import Localizations
import SwiftUI
import UDF

struct WhereToWatchComponent: Component {
    struct Props {
        var item: any Item
        var countries: [DropdownItem]
        var providers: [Provider]
    }

    var props: Props

    @State private var isSelecting: Bool = false
    @State private var selectedCountry: DropdownItem?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack(spacing: 19) {
                    ImageContainer(
                        size: .init(width: 97, height: 132),
                        path: props.item.posterPath
                    )
                    .frame(width: 97, height: 132)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    Text(props.item.title)
                        .customFont(.title3)
                        .foregroundStyle(.flText)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)

                DropdownSelector(
                    placeholder: Localization.whereToWatchSelectCountryTitle(),
                    options: filteredCountries,
                    isSelecting: $isSelecting,
                    selectedItem: $selectedCountry
                )
                .padding(.horizontal, 15)

                VStack(spacing: 30) {
                    ForEach(props.providers, id: \.type) { provider in
                        providerRow(provider)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            if let firstCountry = props.countries.first {
                selectedCountry = firstCountry
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Localization.whereToWatchNavigationTitle())
                    .customFont(.headline)
                    .foregroundStyle(.flText)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 0.3), value: isSelecting)
    }
}

private extension WhereToWatchComponent {
    var filteredCountries: [DropdownItem] {
        return props.countries.filter {
            if let selectedCountry = selectedCountry {
                return $0.title != selectedCountry.title
            }
            return true
        }
    }

    func providerRow(_ provider: Provider) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(provider.type.localizableTitle)
                .customFont(.callout)
                .foregroundStyle(.flText)
                .padding(.horizontal)
            providerItemRow(items: provider.items)
        }
    }

    func providerItemRow(items: [ProviderItem]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(items, id: \.id) { item in
                    providerItem(item)
                }
            }
            .padding(.horizontal)
        }
    }

    func providerItem(_ item: ProviderItem) -> some View {
        ImageContainer(
            size: .init(width: 70, height: 70),
            path: item.logoPath,
            type: .profile
        )
        .frame(width: 70, height: 70)
        .clipShape(RoundedRectangle(cornerRadius: 14.0))
    }
}

// MARK: - Preview

#Preview {
    WhereToWatchComponent(
        props: .init(
            item: Movie.fakeItem(),
            countries: {
                let codes = [
                    "AL", "SA", "AM", "AZ", "BY", "BA", "BG", "MM", "CN", "HR", "CZ", "DK", "MV", "NL",
                    "EE", "FJ", "FI", "FR", "GE", "DE", "GR", "HT", "IN", "HU", "ID", "GB", "IS", "IT",
                    "JP", "GL", "KZ", "KG", "KR", "LT", "LV", "MK", "MT", "MN", "NP", "NO", "PL", "PT",
                    "RO", "RS", "SK", "SI", "SO", "ES", "SE", "TJ", "TH", "BO", "TM", "TR", "UA", "UZ", "VN",
                ]

                return codes.compactMap { code in
                    guard let flag = Flag(countryCode: code) else { return nil }
                    let image = flag.originalImage
                    return .init(title: code, image: image)
                }
            }(),
            providers: Provider.fakeItems(count: 3)
        )
    )
}
