//
//  ShowsStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 01.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import UDFMacros
@preconcurrency import Models

@Storage(Show.self)
@StorageRelationships(
    .hasMany(ShowSection.self, name: "showsBySectionId", label: "section"),
    .hasMany(Show.self, name: "recommendationsByShowId", label: "recommendationsFor")
)
struct AllShows: Storage {}
