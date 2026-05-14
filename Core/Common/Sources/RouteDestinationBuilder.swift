//
//  RouteDestinationBuilder.swift
//  Flick
//
//  Created by Bogdan Petkanych on 14.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF

public struct RouteDestinationBuilder<Route: Hashable>: Routing {
    
    public init() { }
    
    public init(destination: @escaping (Route) -> some View) {
        self.destination = destination
    }
    
    public var destination: (Route) -> any View = { _ in EmptyView() }

    @ViewBuilder
    public func view(for route: Route) -> some View {
        AnyView(destination(route))
    }
}
