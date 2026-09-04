//
//  SectionDetailsFeature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
import Models

public protocol SectionDetailsFeature: AppReducer {
    associatedtype NetworkConnectivityForm: SectionDetails.NetworkConnectivityForm
    associatedtype AllMovies: SectionDetails.AllMovies
    associatedtype AllShows: SectionDetails.AllShows
    associatedtype HomeForm: SectionDetails.HomeForm
    associatedtype AllGenres: Storage<Genre>
    
    var homeForm: HomeForm { get }
    var sectionDetailsFlow: SectionDetailsFlow { get }
    var sectionDetailsForm: SectionDetailsForm { get }
    var networkConnectivityForm: NetworkConnectivityForm { get }
    
    var allGenres: AllGenres { get }
    var allMovies: AllMovies { get }
    var allShows: AllShows { get }
}

public enum SectionDetails {
    public protocol NetworkConnectivityForm: Form {
        var satisfied: Bool { get }
    }
    
    public protocol AllMovies: Storage<Movie> {
        var moviesBySectionId: [MovieSection.ID: OrderedSet<Movie.ID>] { get }
    }
    
    public protocol AllShows: Storage<Show> {
        var showsBySectionId: [ShowSection.ID: OrderedSet<Show.ID>] { get }
    }
    
    public protocol HomeForm: Form {
        var dialog: DialogStatus { get set }
    }
}
