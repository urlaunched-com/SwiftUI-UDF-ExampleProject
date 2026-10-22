//
//  SignInForm.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import SwiftFoundation
import UDF

public struct SignInForm: Form {
    var username: String = ""
    var password: String = ""
    var dialog: DialogStatus = .dismissed
    
    public init() {}

    public mutating func reduce(_: some Action) {}
}
