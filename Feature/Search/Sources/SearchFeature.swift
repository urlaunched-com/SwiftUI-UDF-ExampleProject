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

public protocol SearchFeature: AppReducer {
    associatedtype SearchNetworkConnectivityForm: Search.NetworkConnectivityForm
    associatedtype SearchAllSearchItems: Storage<SearchItem>
    associatedtype SearchNavigation: Common.FeatureNavigation where SearchNavigation.Routing.Route == SearchRoute
    
    var searchForm: SearchForm { get }
    var searchFlow: SearchFlow { get }
    var networkConnectivityForm: SearchNetworkConnectivityForm { get }
    
    var allSearchItems: SearchAllSearchItems { get }
    var searchNavigation: SearchNavigation { get }
}

public enum Search {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
}
