//
//  CastStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import UDFMacros
@preconcurrency import Models

@Storage(Cast.self)
@StorageRelationships(
    .hasMany(Movie.self),
    .hasMany(Show.self)
)
struct AllCast: Storage {}
