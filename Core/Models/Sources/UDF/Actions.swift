//
//  Actions.swift
//  Flick
//
//  Created by Bogdan Petkanych on 18.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import UDF

public extension Actions {
    public struct LoadReviewDetails: Action {
        public let id: AnyHashable
        public let reviewID: Review.ID
        
        public init(id: AnyHashable, reviewID: Review.ID) {
            self.id = id
            self.reviewID = reviewID
        }
    }
    
    public struct LoadHomeSection<H: Hashable>: Action {
        public let sectionId: H
        
        public init(sectionId: H) {
            self.sectionId = sectionId
        }
    }
    
    public struct LoadItemCast<H: Hashable>: Action {
        public let itemId: H
        
        public init(itemId: H) {
            self.itemId = itemId
        }
    }
    
    public struct SectionOpened<H: Hashable>: Action {
        public let sectionId: H
        
        public init(sectionId: H) {
            self.sectionId = sectionId
        }
    }
    
    public struct LoadItemDetails<H: Hashable>: Action {
        public let item: H
        
        public init(item: H) {
            self.item = item
        }
    }
}
