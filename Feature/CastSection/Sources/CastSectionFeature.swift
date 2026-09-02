//
//  CastSectionFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import Models
import UDF

public protocol CastSectionFeature: AppReducer {
    associatedtype CastSectionContainerType: BindableContainer where CastSectionContainerType.ContainerState == Self, CastSectionContainerType.ID == CastSectionTarget
    associatedtype CastSectionNetworkConnectivityForm: CastSection.NetworkConnectivityForm
    associatedtype CastSectionAllCast: CastSection.AllCast
    associatedtype CastSectionNavigation: Common.FeatureNavigation where CastSectionNavigation.Routing.Route == CastSectionRoute

    var castSectionBindableFlow: BindableSource<CastSectionTarget, CastSectionFlow> { get }
    var networkConnectivityForm: CastSectionNetworkConnectivityForm { get }
    var allCast: CastSectionAllCast { get }
    var castSectionNavigation: CastSectionNavigation { get }
}

public enum CastSection {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }

    public protocol AllCast: Storage<Models.Cast> {
        var byMovieId: [Movie.ID: OrderedSet<Models.Cast.ID>] { get }
        var byShowId: [Show.ID: OrderedSet<Models.Cast.ID>] { get }
    }
}
