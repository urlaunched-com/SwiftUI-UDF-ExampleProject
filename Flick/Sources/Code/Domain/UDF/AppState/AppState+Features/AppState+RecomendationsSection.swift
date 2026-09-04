//
//  AppState+RecomendationsSection.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import RecommendationsSection
import Common
import Models
import NetworkConnectivity

extension AppState: RecommendationsSectionFeature {
    typealias RecomendationsSectionContainerType = RecommendationsSectionContainer<Self, RecommendationsSectionRouting>
    
    var recommendationsSectionBindableForm: BindableSource<RecomendationTarget, RecommendationsSectionForm> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: recomendationsSectionForm.map { ($0.key, $0.value) }
            )
        )
    }
    var recommendationsSectionBindableFlow: BindableSource<RecomendationTarget, RecommendationsSectionFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: recomendationsSectionFlow.map { ($0.key, $0.value) }
            )
        )
    }
}

extension NetworkConnectivity.NetworkConnectivityForm: RecommendationsSection.NetworkConnectivityForm {}
extension AllShows: RecommendationsSection.AllShows {}
extension AllMovies: RecommendationsSection.AllMovies {}
extension AllGenres: RecommendationsSection.AllGenres {}
