//
//  HomeContent.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Models
import UDF

public enum HomeContent {
    case mainHomeSection(
        section: any Models.Section,
        retrieveItems: () -> [any Item]
    )
    
    case homeSection(
        section: any Models.Section,
        retrieveItems: () -> [any Item]
    )
}
