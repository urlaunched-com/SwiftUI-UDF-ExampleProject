//
//  Int.swift
//  Flick
//
//  Created by Alexander Sharko on 27.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation

public extension Int {
    var asAmountOfMoney: String {
        guard let amountOfMoney = NumberFormatter.amountOfMoney.string(from: NSNumber(value: self)), self > 0 else {
            return "-"
        }
        return amountOfMoney
    }
}
