//
//  AppRouter.swift
//  Flick
//
//  Created by Bogdan Petkanych on 01.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI
import Auth
import Common
import Home
import Image
import ItemDetails
import Models
import MyFavorites
import Onboarding
import Reviews
import Root
import Search
import Settings

/// Entry points of every flow module the app composes.
enum AppRouter {
    static func root() -> some View {
        RootFeatureState<AppState, RootRouting>.entryPoint()
    }

    static func onboarding() -> some View {
        OnboardingFeatureState<AppState>.entryPoint()
    }

    static func signIn() -> some View {
        SignInFeatureState<AppState, SignInRouting>.entryPoint()
    }

    static func home() -> some View {
        HomeFeatureState<AppState, HomeRouting>.entryPoint()
    }

    static func search() -> some View {
        SearchFeatureState<AppState, SearchRouting>.entryPoint()
    }

    static func myFavorites() -> some View {
        MyFavoritesFeatureState<AppState, MyFavoritesRouting>.entryPoint(input: ())
    }

    static func settings() -> some View {
        SettingsFeatureState<AppState>.entryPoint()
    }

    static func itemDetails(id: ItemDetailsTarget) -> some View {
        ItemDetailsFeatureState<AppState, ItemDetailsRouting>.entryPoint(input: id)
    }

    static func reviews(id: ReviewsTarget) -> some View {
        ReviewsFeatureState<AppState, ReviewsRouting>.entryPoint(input: id)
    }

    static func image(
        size: CGSize,
        path: String?,
        type: ImageType = .poster,
        isLoaderPresented: Bool = true
    ) -> some View {
        let input = ImageFeatureState<AppState>.Input(size: size, path: path, type: type, isLoaderPresented: isLoaderPresented)
        return ImageFeatureState<AppState>.entryPoint(input: input)
    }
}
