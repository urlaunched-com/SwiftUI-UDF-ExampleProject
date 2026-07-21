//
//  Reviews.swift
//  Flick
//
//  Created by Bogdan Petkanych on 20.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

public enum ReviewsTarget: Hashable {
    case show(Show.ID)
    case movie(Movie.ID)
}
