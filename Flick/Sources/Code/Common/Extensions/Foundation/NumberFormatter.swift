//
//  NumberFormatter.swift
//  Flick
//
//  Created by Alexander Sharko on 27.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static var amountOfMoney: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
}
