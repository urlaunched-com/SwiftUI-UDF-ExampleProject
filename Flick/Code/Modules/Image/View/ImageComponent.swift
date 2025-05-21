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

struct ImageComponent: Component {
    struct Props {
        var size: CGSize
        var url: URL?
        var isLoaderPresented: Bool
    }

    var props: Props

    var body: some View {
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
