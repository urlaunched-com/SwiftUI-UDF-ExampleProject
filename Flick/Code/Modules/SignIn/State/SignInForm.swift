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

struct SignInForm: Form {
    var username: String = ""
    var password: String = ""
    var alert: AlertBuilder.AlertStatus = .dismissed

    mutating func reduce(_: some Action) {}
}
