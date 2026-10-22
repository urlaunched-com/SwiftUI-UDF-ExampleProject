//
//  SearchItemsStorage.swift
//  Flick
//
//  Created by Oksana Fedorchuk on 26.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation
import UDF
import UDFMacros
@preconcurrency import SearchModels

@Storage(SearchItem.self)
struct AllSearchItems: Storage {}
