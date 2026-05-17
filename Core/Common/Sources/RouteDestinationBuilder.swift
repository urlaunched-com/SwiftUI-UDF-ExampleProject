//
//  RouteDestinationBuilder.swift
//  Flick
//
//  Created by Bogdan Petkanych on 14.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF

public struct DestinationBuilder<Value> {
    private var destination: (Value) -> any View
    
    public init() {
        self.destination = { _ in EmptyView() }
    }

    public init(@ViewBuilder destination: @escaping (Value) -> any View) {
        self.destination = destination
    }

    @ViewBuilder
    public func view(for value: Value) -> some View {
        AnyView(destination(value))
    }
}
