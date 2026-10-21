//
//  ReviewsStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import UDFMacros
@preconcurrency import MediaModels
@preconcurrency import ReviewModels

@Storage(Review.self)
@StorageRelationships(
    .hasMany(Movie.self),
    .hasMany(Show.self)
)
struct AllReviews: Storage {}
