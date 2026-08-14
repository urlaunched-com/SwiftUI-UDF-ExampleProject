//
//  ItemDetailsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
import Common
import Models

public protocol ItemDetailsFeature: AppReducer {
    associatedtype ItemDetailsContainerType: BindableContainer where ItemDetailsContainerType.ID == ItemDetailsTarget
    associatedtype AllMovies: Storage<Movie>
    associatedtype AllShows: Storage<Show>
    associatedtype AllGenres: Storage<Genre>
    associatedtype NetworkConnectivityForm: ItemDetails.NetworkConnectivityForm

    var itemDetailsBindableFlow: BindableSource<ItemDetailsTarget, ItemDetailsFlow> { get }
    var itemDetailsBindableForm: BindableSource<ItemDetailsTarget, ItemDetailsForm> { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
    var allGenres: AllGenres { get }
}

public enum ItemDetails {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
}
