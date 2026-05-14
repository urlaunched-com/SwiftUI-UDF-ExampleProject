//
//  MockRouter.swift
//  Flick
//
//  Created by Bogdan Petkanych on 14.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
import SwiftUI

public struct MockRouter<Route: Hashable>: Routing {
    public init() {}
    
    public func view(for route: Route) -> some View {
        return EmptyView()
    }
}
