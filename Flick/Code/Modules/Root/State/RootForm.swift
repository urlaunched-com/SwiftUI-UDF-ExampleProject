//
//  RootForm.swift
//  Flick
//
//  Created by Max Kuznetsov on 09.11.2022.
//

import Foundation
import SwiftFoundation
import UDF

struct RootForm: Form {
    var alert: AlertBuilder.AlertStatus = .dismissed

    @StorableValue(key: StorageKey.isNeedToPresentOnboarding, defaultValue: true, storage: UserDefaults.standard)
    var isNeedToPresentOnboarding: Bool

    mutating func reduce(_: some Action) {}
}
