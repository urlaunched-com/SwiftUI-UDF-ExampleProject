//
//  ImageConfigs.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import API
import Foundation
import SwiftFoundation

public struct ImageConfigs: Hashable {
    public var baseUrl: String
    public var secureBaseUrl: String
    public var backdropSizes: [Int]
    public var logoSizes: [Int]
    public var posterSizes: [Int]
    public var profileSizes: [Int]
    public var stillSizes: [Int]

    public init(
        baseUrl: String,
        secureBaseUrl: String,
        backdropSizes: [Int],
        logoSizes: [Int],
        posterSizes: [Int],
        profileSizes: [Int],
        stillSizes: [Int]
    ) {
        self.baseUrl = baseUrl
        self.secureBaseUrl = secureBaseUrl
        self.backdropSizes = backdropSizes
        self.logoSizes = logoSizes
        self.posterSizes = posterSizes
        self.profileSizes = profileSizes
        self.stillSizes = stillSizes
    }
}

// MARK: - asImageConfiguration

public extension ImageConfigsRemote {
    var asImageConfigs: ImageConfigs {
        .init(
            baseUrl: baseUrl,
            secureBaseUrl: secureBaseUrl,
            backdropSizes: backdropSizes.compactMap { Int($0.dropFirst()) },
            logoSizes: logoSizes.compactMap { Int($0.dropFirst()) },
            posterSizes: posterSizes.compactMap { Int($0.dropFirst()) },
            profileSizes: profileSizes.compactMap { Int($0.dropFirst()) },
            stillSizes: stillSizes.compactMap { Int($0.dropFirst()) }
        )
    }
}

// MARK: - Test

public extension ImageConfigs {
    static func testItem(
        baseUrl: String = "",
        secureBaseUrl: String = "",
        backdropSizes: [Int] = [300],
        logoSizes: [Int] = [300],
        posterSizes: [Int] = [300],
        profileSizes: [Int] = [300],
        stillSizes: [Int] = [300]
    ) -> Self {
        .init(
            baseUrl: baseUrl,
            secureBaseUrl: secureBaseUrl,
            backdropSizes: backdropSizes,
            logoSizes: logoSizes,
            posterSizes: posterSizes,
            profileSizes: profileSizes,
            stillSizes: stillSizes
        )
    }
}

public extension ImageConfigs {
    func sizeUrlComponent(for size: CGSize, in sizes: [Int]) -> String {
        let maxImageSize = Int(max(size.width, size.height))
        if let sizeUrlComponent = sizes.first(where: { maxImageSize <= $0 }) {
            return "w\(sizeUrlComponent)"
        }
        return "original"
    }
}

// MARK: - Basic configs

public extension ImageConfigs {
    static var basic: ImageConfigs {
        .init(
            baseUrl: "http://image.tmdb.org/t/p/",
            secureBaseUrl: "https://image.tmdb.org/t/p/",
            backdropSizes: [300, 780, 1280],
            logoSizes: [45, 92, 154, 185, 300, 500],
            posterSizes: [92, 154, 185, 342, 500, 780],
            profileSizes: [45, 185, 632],
            stillSizes: [92, 185, 300]
        )
    }
}
