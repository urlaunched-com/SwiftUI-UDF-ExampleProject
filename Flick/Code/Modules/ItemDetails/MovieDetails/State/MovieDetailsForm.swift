//
//  MovieDetailsForm.swift
//  Flick
//
//  Created by Valentin Petrulia on 14.05.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import UDF

struct MovieDetailsForm: Form {
    var alert: AlertBuilder.AlertStatus = .dismissed
    var movieId: Movie.ID?

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == MovieDetailsFlow.id:
            alert = .init(error: action.error)

        default:
            break
        }
    }
}
