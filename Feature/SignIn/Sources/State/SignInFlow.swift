//
//  SignInFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

public enum SignInFlow: IdentifiableFlow {
    case none, signUp

    public init() { self = .none }

    public mutating func reduce(_: some Action) {}
}
