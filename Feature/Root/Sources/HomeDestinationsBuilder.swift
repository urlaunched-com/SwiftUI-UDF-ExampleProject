//
//  HomeDestinationsBuilder.swift
//  Flick
//
//  Created by Bogdan Petkanych on 23.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
public protocol HomeDestinationBuilder {
    associatedtype DestinationModifier: ViewModifier

    func makeDestinationModifier() -> DestinationModifier
}
