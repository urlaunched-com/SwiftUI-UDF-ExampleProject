//
//  ReviewDetailsFlow.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF
@preconcurrency import Models

public enum ReviewDetailsFlow: IdentifiableFlow {
    case none
    case loading(Review.ID)
    
    public init() {
        self = .none
    }
    
    public mutating func reduce(_ action: some Action) {
        switch action {
        case let action as Actions.LoadReviewDetails where action.id == Self.id:
            self = .loading(action.reviewID)
            
        case let action as Actions.DidLoadItem<Review> where action.id == Self.id:
            self = .none
            
        case let action as Actions.DidCancelEffect where action.cancellation is Cancellation:
            self = .none
            
        default:
            break
        }
    }
}
