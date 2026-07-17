//
//  CastContent.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UIKit

public enum CastContent: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .profile)
}
