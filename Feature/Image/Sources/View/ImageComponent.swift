//
//  ImageComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI
import UDF
import SwiftUI_Kit
import DesignSystem

public struct ImageComponent: Component {
    public struct Props {
        var size: CGSize
        var url: URL?
        var isLoaderPresented: Bool

        public init(size: CGSize, url: URL? = nil, isLoaderPresented: Bool) {
            self.size = size
            self.url = url
            self.isLoaderPresented = isLoaderPresented
        }
    }

    public var props: Props

    public init(props: Props) {
        self.props = props
    }

    public var body: some View {
        WebImage(url: props.url)
            .resizable()
            .renderingMode(.original)
            .placeholder(when: props.url == nil) {
                ZStack {
                    Color.flSecondary
                    if props.isLoaderPresented {
                        ProgressView()
                    }
                }
            }
            .aspectRatio(contentMode: .fill)
    }
}
