//
//  AppState+Recommendations.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Recommendations
import Models
import Common

extension AppState: RecommendationsFeature {
    typealias RecomendationsContainerType = RecommendationsContainer<Self, RecommendationsRouting>
    
    var recommendationsBindableForm: BindableSource<RecomendationTarget, RecommendationsForm> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: recommendationsForm.map { ($0.key, $0.value) }
            )
        )
    }
    var recommendationsBindableFlow: BindableSource<RecomendationTarget, RecommendationsFlow> {
        BindableSource(
            reducers: Dictionary(
                uniqueKeysWithValues: recommendationsFlow.map { ($0.key, $0.value) }
            )
        )
    }
}

extension NetworkConnectivityForm: Recommendations.NetworkConnectivityForm {}
extension AllShows: Recommendations.AllShows {}
extension AllMovies: Recommendations.AllMovies {}
extension AllGenres: Recommendations.AllGenres {}
