//
//  SearchFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 21.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
import Models

public protocol SearchFeature: AppReducer {
    associatedtype NetworkConnectivityForm: Search.NetworkConnectivityForm
    associatedtype AllSearchItems: Search.AllSearchItems
    
    var searchForm: SearchForm { get }
    var searchFlow: SearchFlow { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allSearchItems: AllSearchItems { get }
}

public enum Search {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllSearchItems: Reducible {
        func searchItemBy(id: SearchItem.ID) -> SearchItem
    }
}
