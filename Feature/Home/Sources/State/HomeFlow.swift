//
//  HomeFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 30.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models

public enum HomeFlow: IdentifiableFlow, HomeFeatureTypes.HomeFlow {
    case none, loading

    public init() { self = .none }

    public var isLoading: Bool {
        self == .loading
    }

    public mutating func reduce(_ action: some Action) {
        switch action {
        case is Actions.LoadHomeSection<MovieSection>:
            self = .loading

        case is Actions.LoadHomeSection<ShowSection>:
            self = .loading

        case is Actions.DidLoadItems<Movie>:
            self = .none

        case is Actions.DidLoadItems<Show>:
            self = .none

        case let action as Actions.DidCancelEffect where action.cancellation is HomeCancellation:
            self = .none

        default:
            break
        }
    }
}
