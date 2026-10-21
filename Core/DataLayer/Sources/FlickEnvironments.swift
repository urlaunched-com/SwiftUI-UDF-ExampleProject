//
//  FlickEnvironments.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.10.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import CastSection
import Home
import Image
import ItemDetails
import MyFavorites
import Recommendations
import RecommendationsSection
import ReviewDetails
import Reviews
import ReviewsSection
import Search
import SectionDetails

/// API-backed environments shared by the app. Features depend only on their environment protocols.
public enum FlickEnvironments:
    CastSectionEnvironmentProviding,
    HomeEnvironmentProviding,
    ImageEnvironmentProviding,
    ItemDetailsEnvironmentProviding,
    MyFavoritesEnvironmentProviding,
    RecommendationsEnvironmentProviding,
    RecommendationsSectionEnvironmentProviding,
    ReviewDetailsEnvironmentProviding,
    ReviewsEnvironmentProviding,
    ReviewsSectionEnvironmentProviding,
    SearchEnvironmentProviding,
    SectionDetailsEnvironmentProviding
{
    public static var castSectionEnvironment: CastSectionEnvironment { .environment }

    public static var homeEnvironment: HomeEnvironment { .environment }
    public static var homeGenresEnvironment: HomeGenresEnvironment { .environment }

    public static var imageEnvironment: ImageEnvironment { .environment }

    public static var itemDetailsEnvironment: ItemDetailsEnvironment { .environment }

    public static var myFavoritesEnvironment: MyFavoritesEnvironment { .environment }

    public static var recommendationsEnvironment: RecommendationsEnvironment { .environment }

    public static var recommendationsSectionEnvironment: RecommendationsSectionEnvironment { .environment }

    public static var reviewDetailsEnvironment: Environment { .environment }

    public static var reviewsEnvironment: ReviewsEnvironment { .environment }

    public static var reviewsSectionEnvironment: ReviewsSectionEnvironment { .environment }

    public static var searchEnvironment: SearchEnvironment { .environment }

    public static var sectionDetailsEnvironment: SectionDetailsEnvironment { .environment }
}
