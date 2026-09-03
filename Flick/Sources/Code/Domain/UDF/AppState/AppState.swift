//
//  AppState.swift
//  Flick
//
//  Created by Max Kuznetsov on 02.11.2022.
//

import Foundation
import UDF

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

struct AppState: AppReducer {
    // MARK: Storages
    
    var allMovies = AllMovies()
    var allShows = AllShows()
    var allGenres = AllGenres()
    var allSearchItems = AllSearchItems()
    var allCast = AllCast()
    var allReviews = AllReviews()

    // MARK: Root

    var rootForm = RootForm()

    // MARK: Tab Bar

    var tabBarForm = TabBar.TabBarForm()

    // MARK: Home

    var homeForm = HomeForm()
    var homeFlow = HomeFlow()

    // MARK: Sign In

    var signInForm = SignInForm()
    var signInFlow = SignInFlow()

    // MARK: Movie Genres

    var movieGenresFlow = MovieGenresFlow()

    // MARK: Show Genres

    var showGenresFlow = ShowGenresFlow()

    // MARK: Search

    var searchForm = SearchForm()
    var searchFlow = SearchFlow()

    // MARK: Network Connectivity

    var networkConnectivityForm = NetworkConnectivity.NetworkConnectivityForm()

    // MARK: Image Configs

    var imageConfigsFlow = ImageConfigsFlow()
    var imageConfigsForm = ImageConfigsForm()

    // MARK: Section Details

    var sectionDetailsForm = SectionDetailsForm()
    var sectionDetailsFlow = SectionDetailsFlow()

    // MARK: Item Details
    
    @BindableReducer(ItemDetailsForm.self, bindedTo: ItemDetailsContainer<Self, ItemDetailsRouting>.self)
    var itemDetailForm
    
    @BindableReducer(ItemDetailsFlow.self, bindedTo: ItemDetailsContainer<Self, ItemDetailsRouting>.self)
    var itemDetailFlow

    // MARK: Cast

    var castForm = CastForm()

    // MARK: Cast Section

    @BindableReducer(CastSectionFlow.self, bindedTo: CastSectionContainer<Self>.self)
    var castSectionFlow

    // MARK: Recommendations

    @BindableReducer(RecommendationsForm.self, bindedTo: RecommendationsContainer<Self>.self)
    var recommendationsForm
    @BindableReducer(RecommendationsFlow.self, bindedTo: RecommendationsContainer<Self>.self)
    var recommendationsFlow
    
    // MARK: Recomendations Section
    
    @BindableReducer(RecommendationsSectionForm.self, bindedTo: RecommendationsSectionContainer<Self, RecommendationsSectionRouting>.self)
    var recomendationsSectionForm
    @BindableReducer(RecommendationsSectionFlow.self, bindedTo: RecommendationsSectionContainer<Self, RecommendationsSectionRouting>.self)
    var recomendationsSectionFlow
    
    // MARK: - Review Details
    
    @BindableReducer(ReviewDetailsForm.self, bindedTo: ReviewDetailsContainer<Self>.self)
    var reviewDetailsForm
    @BindableReducer(ReviewDetailsFlow.self, bindedTo: ReviewDetailsContainer<Self>.self)
    var reviewDetailsFlow
    
    // MARK: - Review Section
    
    @BindableReducer(ReviewsSectionForm.self, bindedTo: ReviewsSectionContainer<Self>.self)
    var reviewsSectionForm
    @BindableReducer(ReviewsSectionFlow.self, bindedTo: ReviewsSectionContainer<Self>.self)
    var reviewsSectionFlow

    // MARK: My Favorites

    var myFavoritesForm = MyFavoritesForm()
    var myFavoritesFlow = MyFavoritesFlow()
    
    // MARK: - FeatureStates
    
    var reviewsFeatureState = ReviewsFeatureState<AppState, ReviewsRouting>()
    var reviewDetailsFeatureState = ReviewDetailsFeatureState<AppState, ReviewDetailsRouting>()
    var castFeatureState = CastFeatureState<AppState, CastRouting>()
}
