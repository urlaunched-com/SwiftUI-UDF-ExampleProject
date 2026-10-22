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

public final class StickyScrollService: NSObject, StickyScrollProtocol {
    public let currentValueSubject = PassthroughSubject<Int, Never>()
    
    public func updateIndex(_ index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.currentValueSubject.send(index)
        }
    }
}

public protocol StickyScrollProtocol {
    func updateIndex(_ index: Int)
}
