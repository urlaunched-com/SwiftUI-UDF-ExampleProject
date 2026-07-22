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
    associatedtype NetworkConnectivityForm: CastSection.NetworkConnectivityForm
    associatedtype AllCast: CastSection.AllCast

    var castSectionBindableFlow: BindableSource<CastSectionTarget, CastSectionFlow> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    var allCast: AllCast { get }
}

public enum CastSection {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }

    public protocol AllCast: Reducible {
        var byMovieId: [Movie.ID: OrderedSet<Models.Cast.ID>] { get }
        var byShowId: [Show.ID: OrderedSet<Models.Cast.ID>] { get }
        func castBy(id: Models.Cast.ID) -> Models.Cast
    }
}
