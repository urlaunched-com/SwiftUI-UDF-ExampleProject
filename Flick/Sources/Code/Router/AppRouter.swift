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
import CastModels
import SectionsModels
import MediaModels
import ReviewModels

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

    static func tabBar() -> some View {
        TabBarFeatureState<AppState>.entryPoint()
    }

    static func cast(ids: [Cast.ID]) -> some View {
        CastFeatureState<AppState, CastRouting>.entryPoint(input: ids)
    }

    static func castSection(id: CastSectionTarget) -> some View {
        CastSectionFeatureState<AppState, CastSectionRouting>.entryPoint(input: id)
    }

    static func homeSection<S: SectionsModels.Section>(section: S, items: [any Item]) -> some View {
        let input = HomeSectionFeatureState<AppState, HomeSectionRouting>.Input(section: section, items: items)
        return HomeSectionFeatureState<AppState, HomeSectionRouting>.entryPoint(input: input)
    }

    @ViewBuilder
    static func mainHomeSection<S: SectionsModels.Section>(section: S, items: [any Item]) -> some View {
        if let movieSection = section as? MovieSection {
            MainHomeSectionFeatureState<AppState, MainHomeSectionRouting>.entryPoint(input: .movie(section: movieSection, items: items))
        } else if let showSection = section as? ShowSection {
            MainHomeSectionFeatureState<AppState, MainHomeSectionRouting>.entryPoint(input: .show(section: showSection, items: items))
        }
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

    static func itemDetails(id: ItemDetailsTarget) -> some View {
        ItemDetailsFeatureState<AppState, ItemDetailsRouting>.entryPoint(input: id)
    }

    static func recommendations(id: MediaReference) -> some View {
        RecommendationsFeatureState<AppState, RecommendationsRouting>.entryPoint(input: id)
    }

    static func recommendationsSection(id: MediaReference) -> some View {
        RecommendationsSectionFeatureState<AppState, RecommendationsSectionRouting>.entryPoint(input: id)
    }

    static func reviewDetails(reviewID: Review.ID) -> some View {
        ReviewDetailsFeatureState<AppState, ReviewDetailsRouting>.entryPoint(input: reviewID)
    }

    static func reviews(id: ReviewsTarget) -> some View {
        ReviewsFeatureState<AppState, ReviewsRouting>.entryPoint(input: id)
    }

    static func reviewsSection(id: ReviewsTarget) -> some View {
        ReviewsSectionFeatureState<AppState, ReviewsSectionRouting>.entryPoint(input: id)
    }

    @ViewBuilder
    static func sectionDetails(section: any SectionsModels.Section) -> some View {
        if let movieSection = section as? MovieSection {
            SectionDetailsFeatureState<AppState, SectionDetailsRouting>.entryPoint(input: .movie(movieSection))
        } else if let showSection = section as? ShowSection {
            SectionDetailsFeatureState<AppState, SectionDetailsRouting>.entryPoint(input: .show(showSection))
        }
    }

    static func whereToWatch(item: any Item) -> some View {
        WhereToWatchFeatureState<AppState, WhereToWatchRouting>.entryPoint(input: .init(item: item))
    }
}
