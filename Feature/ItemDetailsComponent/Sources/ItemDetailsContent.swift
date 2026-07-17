//
//  ItemDetailsContent.swift
//  Flick
//
//  Created by Bogdan Petkanych on 17.05.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import Common
import UIKit

public enum ItemDetailsContent: Hashable {
    case imageContainer(path: String?, size: CGSize, type: ImageType = .poster)
}
