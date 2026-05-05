//
//  Common.swift
//  Flick
//
//  Created by Alexander Sharko on 20.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI

// MARK: - Typealiases

public typealias Minutes = Int

// MARK: - Constants

public let kPerPage: Int = 20

// MARK: - AppLink

public enum AppLink: String, Identifiable {
    case aboutUs = "https://www.themoviedb.org/about"
    case tmdbAPI = "https://developer.themoviedb.org/docs/getting-started"
    case privacyPolicy = "https://www.themoviedb.org/privacy-policy"

    public var id: Self { self }
    public var urlValue: URL { URL(string: rawValue)! }
}

// MARK: - Helpers

public func areEqual<Lhs: Equatable>(_ lhs: Lhs, _ rhs: some Equatable) -> Bool {
    guard let rhsAs = rhs as? Lhs else {
        return false
    }

    return lhs == rhsAs
}
