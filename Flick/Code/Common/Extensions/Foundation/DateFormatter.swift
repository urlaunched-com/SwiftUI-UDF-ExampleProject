//
//  DateFormatter.swift
//  Flick
//
//  Created by Alexander Sharko on 05.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var customIso8601ShortFromServer: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static var year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
}
