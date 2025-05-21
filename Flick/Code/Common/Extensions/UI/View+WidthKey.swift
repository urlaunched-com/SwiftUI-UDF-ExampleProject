//
//  View+WidthKey.swift
//  Flick
//
//  Created by Alexander Sharko on 07.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI

extension View {
    func width(_ width: CGFloat) -> some View {
        environment(\.width, width)
    }
}

private struct WidthKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0
}

extension EnvironmentValues {
    var width: CGFloat {
        get { self[WidthKey.self] }
        set { self[WidthKey.self] = newValue }
    }
}
