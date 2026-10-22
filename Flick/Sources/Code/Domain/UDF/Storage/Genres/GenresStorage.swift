//
//  GenresStorage.swift
//  Flick
//
//  Created by Alexander Sharko on 05.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import UDFMacros
@preconcurrency import Models

@Storage(Genre.self)
struct AllGenres: Storage {}
