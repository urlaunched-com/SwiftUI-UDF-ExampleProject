//
//  RecomendationTarget.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

public enum RecomendationTarget: Hashable {
    case show(Show.ID)
    case movie(Movie.ID)
}
