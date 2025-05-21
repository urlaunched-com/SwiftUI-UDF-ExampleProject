//
//  DropdownSelector.swift
//  Flick
//
//  Created by Arthur Zavolovych on 16.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI

struct DropdownItem {
    var title: String
    var image: UIImage
}

struct DropdownSelector: View {
    var placeholder: String
    var options: [DropdownItem]

    @Binding var isSelecting: Bool
    @Binding var selectedItem: DropdownItem?

    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Image.location
                    .renderingMode(.template)
                    .aspectFit()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(isSelecting ? .flMainPink : .flPurpleLight)
                Text(placeholder)
                    .customFont(.caption)
                    .foregroundStyle(isSelecting ? .flMainPink : .flPurpleLight)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                Image(uiImage: selectedItem?.image ?? .init(systemName: "flag.fill")!)
                Text(selectedItem?.title ?? Localization.whereToWatchSelectCountryTitle())
                    .customFont(.body)
                    .foregroundStyle(.flText)
                Spacer()
                Image.Arrow.down
                    .renderingMode(.template)
                    .aspectFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(isSelecting ? .flMainPink : .flPurpleLight)
                    .rotationEffect(.degrees(isSelecting ? 180 : 0))
                    .animation(.easeInOut(duration: 0.3), value: isSelecting)
            }
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .background(isSelecting ? Color.flMainPink : Color.flPurpleLight)

            if isSelecting {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(options, id: \.title) { option in
                            dropdownSelectorRow(option: option, isLast: options.last?.title == option.title)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .background(Color.flSecondary)
                .frame(maxWidth: .infinity, maxHeight: 184)
                .cornerRadius(16, corners: [.topLeft, .bottomLeft, .bottomRight])
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isSelecting.toggle()
        }
    }
}

// MARK: - DropdownSelectorRow

private extension DropdownSelector {
    func dropdownSelectorRow(option: DropdownItem, isLast: Bool = false) -> some View {
        VStack(spacing: 0) {
            Button(action: {
                isSelecting = false
                selectedItem = option
            }) {
                HStack(spacing: 10) {
                    Image(uiImage: option.image)
                        .aspectFit()
                        .frame(width: 22, height: 22)
                    Text(option.title)
                        .customFont(.body)
                        .foregroundStyle(.flText)
                    Spacer()
                }
                .padding(12)
            }
            if !isLast {
                Divider()
                    .opacity(0.1)
                    .background(Color.flPurpleLight)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DropdownSelector(
        placeholder: Localization.whereToWatchSelectCountryTitle(),
        options: Array(repeating: .init(title: "Option", image: UIImage(systemName: "flag.fill")!), count: 4),
        isSelecting: .constant(false),
        selectedItem: .constant(.init(title: "Selected country", image: UIImage(systemName: "flag.fill")!))
    )
}
