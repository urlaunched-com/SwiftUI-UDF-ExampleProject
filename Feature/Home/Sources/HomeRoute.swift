//
//  HomeRoute.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models

public enum HomeRoute: Hashable {
    case mainMovieSection(section: MovieSection, items: [Movie])
    case mainShowSection(section: ShowSection, items: [Show])
    case movieSection(section: MovieSection, items: [Movie])
    case showSection(section: ShowSection, items: [Show])
}
