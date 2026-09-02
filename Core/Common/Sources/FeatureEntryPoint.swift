//
//  FeatureEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import SwiftUI
import UDF

public protocol FeatureEntryPoint {
    associatedtype Parameters
    associatedtype Container: View
    
    init(parameters: Parameters)

    @ViewBuilder
    func make() -> Container
}
