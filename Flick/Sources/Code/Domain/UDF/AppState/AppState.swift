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

    var tabBarForm = TabBarForm()

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

    var networkConnectivityForm = NetworkConnectivityForm()

    // MARK: Image Configs

    var imageConfigsFlow = ImageConfigsFlow()
    var imageConfigsForm = ImageConfigsForm()

    // MARK: Section Details

    var sectionDetailsForm = SectionDetailsForm()
    var sectionDetailsFlow = SectionDetailsFlow()

    // MARK: Movie Details

    @BindableReducer(MovieDetailsForm.self, bindedTo: MovieDetailsContainer.self)
    var movieDetailsForm
    @BindableReducer(MovieDetailsFlow.self, bindedTo: MovieDetailsContainer.self)
    var movieDetailsFlow

    // MARK: Show Details

    @BindableReducer(ShowDetailsForm.self, bindedTo: ShowDetailsContainer.self)
    var showDetailsForm
    @BindableReducer(ShowDetailsFlow.self, bindedTo: ShowDetailsContainer.self)
    var showDetailsFlow

    // MARK: Cast

    var castForm = CastForm()

    // MARK: Movie Cast

    @BindableReducer(MovieCastFlow.self, bindedTo: MovieCastContainer.self)
    var movieCastFlow

    // MARK: Show Cast

    @BindableReducer(ShowCastFlow.self, bindedTo: ShowCastContainer.self)
    var showCastFlow

    // MARK: Movie Recommendations

    @BindableReducer(MovieRecommendationsForm.self, bindedTo: MovieRecommendationsContainer.self)
    var movieRecommendationsForm
    @BindableReducer(MovieRecommendationsFlow.self, bindedTo: MovieRecommendationsContainer.self)
    var movieRecommendationsFlow

    // MARK: Show Recommmendations

    @BindableReducer(ShowRecommendationsForm.self, bindedTo: ShowRecommendationsContainer.self)
    var showRecommendationsForm
    @BindableReducer(ShowRecommendationsFlow.self, bindedTo: ShowRecommendationsContainer.self)
    var showRecommendationsFlow

    // MARK: Movie Details Recommendations

    @BindableReducer(MovieRecommendationsForm.self, bindedTo: MovieDetailsRecommendationsContainer.self)
    var movieDetailsRecommendationsForm
    @BindableReducer(MovieRecommendationsFlow.self, bindedTo: MovieDetailsRecommendationsContainer.self)
    var movieDetailsRecommendationsFlow

    // MARK: Show Details Recommendations

    @BindableReducer(ShowRecommendationsForm.self, bindedTo: ShowDetailsRecommendationsContainer.self)
    var showDetailsRecommendationsForm
    @BindableReducer(ShowRecommendationsFlow.self, bindedTo: ShowDetailsRecommendationsContainer.self)
    var showDetailsRecommendationsFlow
    
    // MARK: - Reviews
    
    @BindableReducer(ReviewsForm.self, bindedTo: ReviewsContainer<Self, ReviewsRouting>.self)
    var reviewsForm
    @BindableReducer(ReviewsFlow.self, bindedTo: ReviewsContainer<Self, ReviewsRouting>.self)
    var reviewsFlow
    
    // MARK: - Review Details
    
    @BindableReducer(ReviewDetailsForm.self, bindedTo: ReviewDetailsContainer<Self, ReviewDetailsRouting>.self)
    var reviewDetailsForm
    @BindableReducer(ReviewDetailsFlow.self, bindedTo: ReviewDetailsContainer<Self, ReviewDetailsRouting>.self)
    var reviewDetailsFlow
    
    // MARK: - Review Section
    
    @BindableReducer(ReviewsSectionForm.self, bindedTo: ReviewsSectionContainer<Self, ReviewsSectionRouting>.self)
    var reviewsSectionForm
    @BindableReducer(ReviewsSectionFlow.self, bindedTo: ReviewsSectionContainer<Self, ReviewsSectionRouting>.self)
    var reviewsSectionFlow

    // MARK: My Favorites

    var myFavoritesForm = MyFavoritesForm()
    var myFavoritesFlow = MyFavoritesFlow()
}
