//
//  Router.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UIKit

public enum ReviewDetailsRoute: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .profile)
}
