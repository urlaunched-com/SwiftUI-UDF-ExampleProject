//
//  HomeForm.swift
//  Flick
//
//  Created by Alexander Sharko on 30.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import UDF
@preconcurrency import Models

struct HomeForm: Form {
    var contentType: ContentType = .movie
    var dialog: DialogStatus = .dismissed

    mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.Error where action.id == HomeFlow.id:
            dialog = .init(error: action.error)

        default:
            break
        }
    }
}
