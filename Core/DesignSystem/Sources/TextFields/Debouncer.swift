//
//  Debouncer.swift
//  DesignSystem
//
//  Created by Valentin Petrulia on 15.05.2025.
//

import Combine
import SwiftUI

public final class Debouncer<T>: ObservableObject {
    @Published var debouncedValue: T
    @Published var value: T

    private var cancelation: AnyCancellable!

    init(defaultValue: T, debounceTime: TimeInterval = 0.1) {
        value = defaultValue
        debouncedValue = defaultValue

        cancelation = $value
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.debouncedValue = text
            }
    }
}
