//
//  CustomFont.swift
//
//
//  Created by Alexander Sharko on 10.11.2022.
//

import SwiftUI

public extension View {
    func customFont(_ textStyle: Font.TextStyle) -> some View {
        modifier(CustomFont(textStyle: UIFont.TextStyle(textStyle)!))
    }
}

private struct CustomFont: ViewModifier {
    let textStyle: UIFont.TextStyle

    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory

    func body(content: Content) -> some View {
        guard let fontDescription = fontDescriptions[textStyle] else {
            fatalError()
        }

        return content.font(.custom(fontDescription.fontName, size: fontDescription.fontSize))
    }
}

extension UIFont.TextStyle {
    init?(_ textStyle: Font.TextStyle) {
        let styles: [Font.TextStyle: UIFont.TextStyle] = [
            .largeTitle: .largeTitle,
            .title: .title1,
            .title2: .title2,
            .title3: .title3,
            .headline: .headline,
            .subheadline: .subheadline,
            .body: .body,
            .callout: .callout,
            .footnote: .footnote,
            .caption: .caption1,
            .caption2: .caption2,
        ]

        guard let style = styles[textStyle] else {
            return nil
        }

        self = style
    }
}

typealias CustomFontDescription = (fontName: String, fontSize: CGFloat)

var fontDescriptions: [UIFont.TextStyle: CustomFontDescription] = [
    .largeTitle: ("Poppins-SemiBold", 24),
    .title1: ("Poppins-SemiBold", 22),
    .title2: ("Poppins-SemiBold", 20),
    .title3: ("Poppins-SemiBold", 16),
    .headline: ("Poppins-SemiBold", 18),
    .body: ("Poppins-Regular", 14),
    .callout: ("Poppins-SemiBold", 14),
    .subheadline: ("Poppins-Regular", 16),
    .caption1: ("Poppins-Regular", 12),
    .caption2: ("Poppins-Regular", 10),
]
