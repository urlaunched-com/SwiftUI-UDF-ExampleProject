//
//  AppRouter.swift
//  Flick
//
//  Created by Bogdan Petkanych on 01.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import SwiftUI
import Cast
import CastSection
import Common
import Home
import HomeSection
import Image
import ItemDetails
import MainHomeSection
import Models
import MyFavorites
import Onboarding
import Recommendations
import RecommendationsSection
import ReviewDetails
import Reviews
import ReviewsSection
import Root
import Search
import SectionDetails
import Settings
import SignIn
import TabBar
import WhereToWatch

struct AppRouter {
    var reviewsRouting = ReviewsRouting()
    var reviewsSectionRouting = ReviewsSectionRouting()
    var reviewDetailsRouting = ReviewDetailsRouting()
    var castRouting = CastRouting()
    var castSectionRouting = CastSectionRouting()
    var signInRouting = SignInRouting()
    var searchRouting = SearchRouting()
    var myFavoritesRouting = MyFavoritesRouting()
    var recommendationsRouting = RecommendationsRouting()
    var whereToWatchRouting = WhereToWatchRouting()
    
    static var shared = Self()
    
    static func root() -> some View {
        RootEntryPoint<AppState, RootRouting>.make(with: .init())
    }

    static func onboarding() -> some View {
        OnboardingEntryPoint<AppState>.make(with: .init())
    }

    static func signIn() -> some View {
        SignInEntryPoint<AppState>.make(with: .init())
    }

    static func home() -> some View {
        HomeFeatureState<AppState, HomeRouting>.entryPoint()
    }

    static func search() -> some View {
        SearchEntryPoint<AppState>.make(with: .init())
    }

    static func myFavorites() -> some View {
        MyFavoritesEntryPoint<AppState>.make(with: .init())
    }

    static func settings() -> some View {
        SettingsEntryPoint<AppState>.make(with: .init())
    }

    static func tabBar() -> some View {
        TabBarEntryPoint<AppState>.make(with: .init())
    }

    static func cast(ids: [Cast.ID]) -> some View {
        CastFeatureState<AppState, CastRouting>.entryPoint(input: ids)
    }

    static func castSection(id: CastSectionTarget) -> some View {
        CastSectionFeatureState<AppState, CastSectionRouting>.entryPoint(input: id)
    }

    static func homeSection<S: Models.Section>(section: S, items: [any Item]) -> some View {
        HomeSectionEntryPoint<AppState, S, HomeSectionRouting>.make(with: .init(section: section, items: items))
    }

    static func mainHomeSection<S: Models.Section>(section: S, items: [any Item]) -> some View {
        MainHomeSectionEntryPoint<AppState, S, MainHomeSectionRouting>.make(with: .init(section: section, items: items))
    }

    static func image(
        size: CGSize,
        path: String?,
        type: ImageType = .poster,
        isLoaderPresented: Bool = true
    ) -> some View {
        ImageEntryPoint<AppState>.make(
            with: .init(
                size: size,
                path: path,
                type: type,
                isLoaderPresented: isLoaderPresented
            )
        )
    }

    static func itemDetails(id: ItemDetailsTarget) -> some View {
        ItemDetailsEntryPoint<AppState, ItemDetailsRouting>.make(with: .init(id: id))
    }

    static func recommendations(id: RecomendationTarget) -> some View {
        RecommendationsEntryPoint<AppState>.make(with: .init(id: id))
    }

    static func recommendationsSection(id: RecomendationTarget) -> some View {
        RecommendationsSectionEntryPoint<AppState, RecommendationsSectionRouting>.make(with: .init(id: id))
    }

    static func reviewDetails(reviewID: Review.ID) -> some View {
        ReviewDetailsFeatureState<AppState, ReviewDetailsRouting>.entryPoint(input: reviewID)
    }

    static func reviews(id: ReviewsTarget) -> some View {
        ReviewsFeatureState<AppState, ReviewsRouting>.entryPoint(input: id)
    }

    static func reviewsSection(id: ReviewsTarget) -> some View {
        ReviewsSectionEntryPoint<AppState>.make(with: .init(id: id))
    }

    static func sectionDetails<S: Models.Section>(section: S) -> some View {
        SectionDetailsEntryPoint<AppState, S, SectionDetailsRouting>.make(with: .init(section: section))
    }

    static func whereToWatch(item: any Item) -> some View {
        WhereToWatchEntryPoint<AppState>.make(with: .init(item: item))
    }
}
