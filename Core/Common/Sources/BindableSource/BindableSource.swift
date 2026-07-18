//
//  BindableSource.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SwiftUI
import UDF

public struct BindableSource<ID: Hashable & Sendable, R: Reducible>: Reducible {
    
    public typealias Reducers = [ID: R]
    
    public var reducers: Reducers
    
    public init(reducers: Reducers = .init()) {
        self.reducers = reducers
    }
    
    public init() {
        self.reducers = [:]
    }
    
    public subscript(_ id: ID) -> Scope {
        ReducerScope(reducer: reducers[id])
    }
    
    public subscript(_ id: ID) -> R? {
        reducers[id]
    }
    
    public static func == (lhs: BindableSource<ID, R>, rhs: BindableSource<ID, R>) -> Bool {
        lhs.reducers == rhs.reducers
    }
    
    final class ReducerScope: EquatableScope, Sendable {
        let reducer: R?
        
        init(reducer: R?) {
            self.reducer = reducer
        }

        static func == (lhs: ReducerScope, rhs: ReducerScope) -> Bool {
            lhs.reducer == rhs.reducer
        }
    }
}

extension BindableSource: Collection {
    public typealias Index = Reducers.Index
    public typealias Element = (key: ID, value: R)

    public var startIndex: Index { reducers.startIndex }
    public var endIndex: Index { reducers.endIndex }
    
    public subscript(index: Index) -> Element {
        let element = reducers[index]
        return (element.key, element.value)
    }

    public func index(after i: Index) -> Index {
        reducers.index(after: i)
    }
}
