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
}
