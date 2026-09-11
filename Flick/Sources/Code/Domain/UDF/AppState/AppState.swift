//
//  AppState.swift
//  Flick
//
//  Created by Max Kuznetsov on 02.11.2022.
//

import Foundation
import UDF
import Common
import SignIn
import ReviewDetails
import Reviews
import ReviewsSection
import Search
import MyFavorites
import Cast
import CastSection
import Image
import Home
import NetworkConnectivity
import Root
import TabBar
import Recommendations
import RecommendationsSection
import SectionDetails
import ItemDetails
import HomeSection
import MainHomeSection
import Onboarding
import Settings
import WhereToWatch

struct AppState: AppReducer {
    // MARK: Storages
    var allMovies = AllMovies()
    var allShows = AllShows()
    var allGenres = AllGenres()
    var allSearchItems = AllSearchItems()
    var allCast = AllCast()
    var allReviews = AllReviews()
    
    // MARK: - FeatureStates
    var reviewsFeatureState = ReviewsFeatureState<AppState, ReviewsRouting>()
    var reviewDetailsFeatureState = ReviewDetailsFeatureState<AppState, ReviewDetailsRouting>()
    var castFeatureState = CastFeatureState<AppState, CastRouting>()
    var castSectionFeatureState = CastSectionFeatureState<AppState, CastSectionRouting>()
    var homeFeatureState = HomeFeatureState<AppState, HomeRouting>()
    var homeSectionFeatureState = HomeSectionFeatureState<AppState, HomeSectionRouting>()
    var imageFeatureState = ImageFeatureState<AppState>()
    var myFavoritesFeatureState = MyFavoritesFeatureState<AppState, MyFavoritesRouting>()
    var itemDetailsFeatureState = ItemDetailsFeatureState<AppState, ItemDetailsRouting>()
    var mainHomeSectionFeatureState = MainHomeSectionFeatureState<AppState, MainHomeSectionRouting>()
    var networkConnectivityFeatureState = NetworkConnectivityFeatureState<AppState>()
    var onboardingFeatureState = OnboardingFeatureState<AppState>()
    var recommendationsFeatureState = RecommendationsFeatureState<AppState, RecommendationsRouting>()
    var recommendationsSectionFeatureState = RecommendationsSectionFeatureState<AppState, RecommendationsSectionRouting>()
    var reviewsSectionFeatureState = ReviewsSectionFeatureState<AppState, ReviewsSectionRouting>()
    var rootFeatureState = RootFeatureState<AppState, RootRouting>()
    var searchFeatureState = SearchFeatureState<AppState, SearchRouting>()
    var sectionDetailsFeatureState = SectionDetailsFeatureState<AppState, SectionDetailsRouting>()
    var settingsFeatureState = SettingsFeatureState<AppState>()
    var signInFeatureState = SignInFeatureState<AppState, SignInRouting>()
    var tabBarFeatureState = TabBarFeatureState<AppState>()
    var whereToWatchFeatureState = WhereToWatchFeatureState<AppState, WhereToWatchRouting>()
}

//MARK: - Access to feature state form/flow, act like bridge to external module
extension AppState {
    var homeForm: Home.HomeForm {
        homeFeatureState.homeForm
    }
    
    var homeFlow: Home.HomeFlow {
        homeFeatureState.homeFlow
    }
    
    var rootForm: Root.RootForm {
        rootFeatureState.rootForm
    }
    
    var tabBarForm: TabBar.TabBarForm {
        tabBarFeatureState.tabBarForm
    }
    
    var movieGenresFlow: MovieGenresFlow {
        homeFeatureState.movieGenresFlow
    }
    
    var showGenresFlow: ShowGenresFlow {
        homeFeatureState.showGenresFlow
    }
    
    var networkConnectivityForm: NetworkConnectivity.NetworkConnectivityForm {
        networkConnectivityFeatureState.networkConnectivityForm
    }
}
