//
//  CastSectionRoute.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import Models
import UIKit
import Common

public enum CastSectionRoute: Hashable {
    case cast([Cast.ID])
    case imageContainer(path: String?, size: CGSize, type: ImageType = .profile)
}
