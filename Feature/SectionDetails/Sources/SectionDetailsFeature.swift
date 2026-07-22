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
    associatedtype AllGenres: SectionDetails.AllGenres
    associatedtype AllMovies: SectionDetails.AllMovies
    associatedtype AllShows: SectionDetails.AllShows
    associatedtype HomeForm: SectionDetails.HomeForm
    
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
    
    public protocol AllGenres: Reducible {
        func genreBy(id: Genre.ID) -> Genre
    }
    
    public protocol AllMovies: Reducible {
        var moviesBySectionId: [MovieSection.ID: OrderedSet<Movie.ID>] { get }
        func movieBy(id: Movie.ID) -> Movie
    }
    
    public protocol AllShows: Reducible {
        var showsBySectionId: [ShowSection.ID: OrderedSet<Show.ID>] { get }
        func showBy(id: Show.ID) -> Show
    }
    
    public protocol HomeForm: Form {
        var dialog: DialogStatus { get set }
    }
}
