//
//  ContentToggle.swift
//  Flick
//
//  Created by Vlad Andrieiev on 24.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI

struct ContentToggle: View {
    @Binding var contentType: ContentType

    @Namespace private var namespace

    var body: some View {
        HStack {
            Group {
                contentTypeButton(.movie, isSelected: contentType == .movie)
                contentTypeButton(.show, isSelected: contentType == .show)
            }
            .frame(maxWidth: .infinity)
        }
        .customFont(.subheadline)
        .padding(.vertical)
    }
}

// MARK: - contentTypeButton

extension ContentToggle {
    private func contentTypeButton(_ type: ContentType, isSelected: Bool) -> some View {
        VStack(spacing: 12) {
            Text(type == .movie ? Localization.contentToggleMoviesTitle() : Localization.contentToggleShowsTitle())
                .foregroundStyle(isSelected ? .flText : .flPurpleLight)
                .onTapGesture {
                    contentType = type
                }

            if isSelected {
                Color.flMainPink
                    .matchedGeometryEffect(id: "contentTypeUnderline", in: namespace)
                    .frame(width: 116, height: 1)
            } else {
                Color.clear
                    .frame(height: 1)
            }
        }
    }
}
