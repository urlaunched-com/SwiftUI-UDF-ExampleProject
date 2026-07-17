//
//  Router.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UIKit
import Common

public enum WhereToWatchRouter: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}
