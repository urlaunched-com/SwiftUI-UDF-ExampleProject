//
//  SignInRouter.swift
//  Flick
//
//  Created by Bogdan Petkanych on 06.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import SwiftUI
import UDF

public struct SignInRouting: Routing {
    public enum Route: Hashable {
        case resetPassword
        case signUp
    }
    
    public init() { }
    
    public init(destination: @escaping (Route) -> some View) {
        self.destination = destination
    }
    
    public var destination: (Route) -> any View = { _ in EmptyView() }

    @ViewBuilder public func view(for route: Route) -> some View {
        AnyView(destination(route))
    }
}
