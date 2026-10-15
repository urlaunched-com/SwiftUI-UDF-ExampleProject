//
//  NavigableFeatureState.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//
import UDF
import SwiftUI

/// A feature whose screens push other screens of the same feature onto the navigation stack hosting it.
public protocol NavigableFeatureState: FeatureState {
    associatedtype Destinations: ViewModifier

    /// Registers the screens the feature pushes internally on the navigation stack that hosts it.
    static var destinations: Destinations { get }
}

public extension View {
    /// Lets this navigation stack show every screen a feature pushes internally, without the app
    /// knowing what those screens are.
    func navigationDestinations<Feature: NavigableFeatureState>(for feature: Feature.Type) -> some View {
        modifier(Feature.destinations)
    }
}
