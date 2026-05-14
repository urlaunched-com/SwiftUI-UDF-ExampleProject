//
//  ReviewsRoute.swift
//  Flick
//
//  Created by Alexander Sharko on 10.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Models

public enum ReviewsRoute: Hashable {
    case reviewDetails(Review.ID)
}
