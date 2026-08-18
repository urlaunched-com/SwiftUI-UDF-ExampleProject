//
//  NavigationDestination.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.08.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI

public protocol NavigationDestination {
    associatedtype DestinationNavigation
    associatedtype DestinationModifier: ViewModifier

    func destination(for destinationNavigation: DestinationNavigation) -> DestinationModifier
}
