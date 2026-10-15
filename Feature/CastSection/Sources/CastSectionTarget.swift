//
//  CastSectionTarget.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MediaModels

public enum CastSectionTarget: Hashable {
    case movie(Movie.ID)
    case show(Show.ID)
}
