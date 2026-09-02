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
import NetworkConnectivity

extension AppState: RecommendationsFeature {
    typealias RecomendationsContainerType = RecommendationsContainer<Self>
    typealias RecommendationsAllGenres = Flick.AllGenres
    typealias RecommendationsAllMovies = Flick.AllMovies
    typealias RecommendationsAllShows = Flick.AllShows

    struct RecommendationsFeatureNavigation: Common.FeatureNavigation {
        typealias Routing = RecommendationsRouting
        typealias EntryPoint = RecommendationsEntryPoint<AppState>

        let routing: RecommendationsRouting
    }
    
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

    var recommendationsNavigation: RecommendationsFeatureNavigation {
        .init(routing: AppRouter.shared.recommendationsRouting)
    }
}

extension NetworkConnectivity.NetworkConnectivityForm: Recommendations.NetworkConnectivityForm {}
extension Flick.AllShows: Recommendations.AllShows {}
extension Flick.AllMovies: Recommendations.AllMovies {}
extension Flick.AllGenres: Recommendations.AllGenres {}
