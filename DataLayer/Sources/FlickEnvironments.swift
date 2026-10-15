//
//  FlickEnvironments.swift
//  Flick
//
//  Created by Maksym Horobets on 15.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Home
import Image
import ItemDetails
import MyFavorites
import Reviews
import Search

/// The live environments of every flow, built on top of the API layer.
///
/// The data layer knows about the flows; the flows never know about it. Changing the API therefore
/// rebuilds only this module and the app.
public enum FlickEnvironments:
    HomeEnvironmentProviding,
    ImageEnvironmentProviding,
    ItemDetailsEnvironmentProviding,
    MyFavoritesEnvironmentProviding,
    ReviewsEnvironmentProviding,
    SearchEnvironmentProviding
{
    // MARK: - Home
    public static var home: HomeEnvironment { .live }
    public static var genres: GenresEnvironment { .live }
    public static var sectionDetails: SectionDetailsEnvironment { .live }

    // MARK: - Image
    public static var imageConfigs: ImageConfigsEnvironment { .live }

    // MARK: - Item Details
    public static var itemDetails: ItemDetailsEnvironment { .live }
    public static var castSection: CastSectionEnvironment { .live }
    public static var recommendationsSection: RecommendationsSectionEnvironment { .live }
    public static var recommendations: RecommendationsEnvironment { .live }

    // MARK: - My Favorites
    public static var myFavorites: MyFavoritesEnvironment { .live }

    // MARK: - Reviews
    public static var reviewsSection: ReviewsSectionEnvironment { .live }
    public static var reviews: ReviewsEnvironment { .live }
    public static var reviewDetails: ReviewDetailsEnvironment { .live }

    // MARK: - Search
    public static var search: SearchEnvironment { .live }
}
