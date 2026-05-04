//
//  View.swift
//  Flick
//
//  Created by Alexander Sharko on 24.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import SwiftUI_Kit
import UDF

extension View {
    func customNavigationTitle(_ title: String) -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .customFont(.headline)
                    .foregroundStyle(.flText)
            }
        }
    }
}
