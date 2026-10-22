//
//  NavigatingFeatureState.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  © 2026 You are launched
//
import UDF
import SwiftUI

/// A feature whose screens push other screens of the same feature onto the navigation stack hosting it.
public protocol NavigatingFeatureState: FeatureState {
    associatedtype Destinations: ViewModifier

    /// The routings of the screens the feature pushes internally, listed one per line:
    ///
    /// ```swift
    /// public static var destinations: some ViewModifier {
    ///     MainHomeSectionRouting<AppState>.self
    ///     HomeSectionRouting<AppState>.self
    /// }
    /// ```
    @DestinationsBuilder
    static var destinations: Destinations { get }
}

/// Collects routing types into one modifier that registers each of them on a navigation stack.
@resultBuilder
public enum DestinationsBuilder {
    public static func buildExpression<R: Routing>(_ routing: R.Type) -> RoutingDestination<R> where R.Route: Hashable {
        RoutingDestination()
    }

    public static func buildBlock() -> EmptyModifier {
        .identity
    }

    public static func buildPartialBlock<First: ViewModifier>(first: First) -> First {
        first
    }

    public static func buildPartialBlock<Accumulated: ViewModifier, Next: ViewModifier>(
        accumulated: Accumulated,
        next: Next
    ) -> ModifiedContent<Accumulated, Next> {
        accumulated.concat(next)
    }
}

/// Registers one routing's routes on the navigation stack.
public struct RoutingDestination<R: Routing>: ViewModifier where R.Route: Hashable {
    public func body(content: Content) -> some View {
        content.navigationDestination(for: R.self)
    }
}

public extension View {
    /// Lets this navigation stack show every screen a feature pushes internally, without the app
    /// knowing what those screens are.
    func navigationDestinations<Feature: NavigatingFeatureState>(for feature: Feature.Type) -> some View {
        modifier(Feature.destinations)
    }
}
