//
//  StickyScrollService.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class StickyScrollService: NSObject {
    let currentValueSubject = PassthroughSubject<Int, Never>()
}

extension StickyScrollService: StickyScrollProtocol {
    func updateIndex(_ index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.currentValueSubject.send(index)
        }
    }
}

protocol StickyScrollProtocol {
    func updateIndex(_ index: Int)
}
