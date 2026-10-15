//
//  Section.swift
//  Flick
//
//  Created by Alexander Sharko on 06.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation
import Common

public protocol Section: Identifiable, CaseIterable, Hashable {
    var title: String { get }
}

/// Compares sections of any concrete type, so `@AutoHashable` routes can carry `any Section`.
public func == (lhs: any Section, rhs: any Section) -> Bool {
    areEqual(lhs, rhs)
}
