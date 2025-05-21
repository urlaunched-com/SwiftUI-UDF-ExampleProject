//
//  Date.swift
//  Flick
//
//  Created by Alexander Sharko on 05.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation

extension Date {
    static var testItem = Date(timeIntervalSince1970: 0)

    var asShortDateString: String {
        DateFormatter.customIso8601ShortFromServer.string(from: self)
    }

    var asYearString: String {
        DateFormatter.year.string(from: self)
    }
}
