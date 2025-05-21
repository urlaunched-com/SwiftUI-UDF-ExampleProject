//
//  SignInFlow.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

enum SignInFlow: IdentifiableFlow {
    case none, signUp

    init() { self = .none }

    mutating func reduce(_: some Action) {}
}
