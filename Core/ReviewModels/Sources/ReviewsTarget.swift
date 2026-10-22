//
//  ReviewsTarget.swift
//  Flick
//
//  Created by Bogdan Petkanych on 20.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import MediaModels

public enum ReviewsTarget: Hashable {
    case show(Show.ID)
    case movie(Movie.ID)

    public init(mediaReference: MediaReference) {
        switch mediaReference {
        case let .movie(id):
            self = .movie(id)
        case let .show(id):
            self = .show(id)
        }
    }
}
