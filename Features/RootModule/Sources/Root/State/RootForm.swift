//
//  RootForm.swift
//  Flick
//
//  Created by Max Kuznetsov on 09.11.2022.
//

import Common
import Foundation
import SwiftFoundation
import UDF

public struct RootForm: Form {
    public var dialog: DialogStatus = .dismissed

    @StorableValue(key: StorageKey.isNeedToPresentOnboarding, defaultValue: true, storage: UserDefaults.standard)
    public var isNeedToPresentOnboarding: Bool

    public init() {}

    public mutating func reduce(_: some Action) {}
}
