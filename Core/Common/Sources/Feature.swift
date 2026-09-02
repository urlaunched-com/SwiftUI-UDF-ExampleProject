//
//  Feature.swift
//  Flick
//
//  Created by Bogdan Petkanych on 02.09.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//
import UDF
import SwiftUI

public protocol FeatureState<AppState>: Reducible {
    associatedtype AppState: AppReducer
    associatedtype Destination: View
    associatedtype Input
    
    static func entryPoint(input: Input) -> Destination
}
