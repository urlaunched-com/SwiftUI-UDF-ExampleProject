//
//  AppState.swift
//  Flick
//
//  Created by Max Kuznetsov on 02.11.2022.
//

import Foundation
import UDF
import Common
import DataLayer
import AuthModule
import HomeModule
import ImageModule
import ItemDetailsModule
import MyFavoritesModule
import NetworkConnectivityModule
import OnboardingModule
import ReviewsModule
import RootModule
import SearchModule
import SettingsModule

struct AppState: AppReducer {
    typealias Environments = FlickEnvironments

    // MARK: Storages
    var allMovies = AllMovies()
    var allShows = AllShows()
    var allGenres = AllGenres()
    var allSearchItems = AllSearchItems()
    var allCast = AllCast()
    var allReviews = AllReviews()

    // MARK: - FeatureStates
    var rootFeatureState = RootFeatureState<AppState, RootRouting>()
    var onboardingFeatureState = OnboardingFeatureState<AppState>()
    var signInFeatureState = SignInFeatureState<AppState, SignInRouting>()
    var homeFeatureState = HomeFeatureState<AppState, HomeRouting>()
    var itemDetailsFeatureState = ItemDetailsFeatureState<AppState, ItemDetailsRouting>()
    var reviewsFeatureState = ReviewsFeatureState<AppState, ReviewsRouting>()
    var searchFeatureState = SearchFeatureState<AppState, SearchRouting>()
    var myFavoritesFeatureState = MyFavoritesFeatureState<AppState, MyFavoritesRouting>()
    var settingsFeatureState = SettingsFeatureState<AppState>()
    var imageFeatureState = ImageFeatureState<AppState>()
    var networkConnectivityFeatureState = NetworkConnectivityFeatureState<AppState>()
}

// MARK: - Bridges to state that one feature owns and another one requires
extension AppState {
    var homeForm: HomeModule.HomeForm {
        homeFeatureState.homeForm
    }

    var rootForm: RootModule.RootForm {
        rootFeatureState.rootForm
    }

    var networkConnectivityForm: NetworkConnectivityModule.NetworkConnectivityForm {
        networkConnectivityFeatureState.networkConnectivityForm
    }
}
