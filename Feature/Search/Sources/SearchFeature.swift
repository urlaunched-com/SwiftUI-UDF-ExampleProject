//
//  SearchFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
import Common
import Models
import SwiftUI

public protocol SearchFeature: AppReducer {
    associatedtype SearchNetworkConnectivityForm: Search.NetworkConnectivityForm
    associatedtype SearchAllSearchItems: Storage<SearchItem>
    associatedtype SearchRouting: Routing<SearchRoute>
    
    var searchFeatureState: SearchFeatureState<Self, SearchRouting> { get }
    var networkConnectivityForm: SearchNetworkConnectivityForm { get }
    
    var allSearchItems: SearchAllSearchItems { get }
}

public struct SearchFeatureState<AppState: SearchFeature, FeatureRouting: Routing<SearchRoute>>: FeatureState {
    var searchForm = SearchForm()
    var searchFlow = SearchFlow()
    
    public init() {}
    
    public static func entryPoint(input: Void = ()) -> some View {
        SearchContainer<AppState>()
    }
}

public enum Search {
    public protocol NetworkConnectivityForm: UDF.Form {
        var satisfied: Bool { get }
    }
}
