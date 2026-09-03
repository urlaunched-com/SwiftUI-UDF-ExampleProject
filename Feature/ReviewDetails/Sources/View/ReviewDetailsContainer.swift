//
//  ShowReviewDetailsContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 08.02.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import UDF
import Models
import Common
import SwiftUI

struct ReviewDetailsContainer<F: ReviewDetailsFeature>: BindableContainer {
    typealias ContainerComponent = ReviewDetailsComponent<F.ReviewDetailsFeatureRouting>
    
    let id: Review.ID

    func scope(for state: F) -> Scope {
        state.allReviews
        state.reviewDetailsFeatureState.reviewDetailsFlow[id]
        state.reviewDetailsFeatureState.reviewDetailsForm[id]
    }
    
    init(id: Review.ID) {
        self.id = id
    }

    func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            id: id,
            reviewByID: reviewById(_:),
            isRedacted: isRedacted,
            dialog: dialog
        )
    }

    func onContainerDidLoad(store: EnvironmentStore<F>) {
        store.dispatch(Actions.LoadReviewDetails(id: ReviewDetailsFlow.id, reviewID: id).binded(to: self))
    }
}

// MARK: - Props

private extension ReviewDetailsContainer {
    var flow: ReviewDetailsFlow {
        store.state.reviewDetailsFeatureState.reviewDetailsFlow[id] ?? .init()
    }

    var form: ReviewDetailsForm {
        store.state.reviewDetailsFeatureState.reviewDetailsForm[id] ?? .init()
    }
    
    var dialog: Binding<DialogStatus> {
        Binding {
            form.dialog
        } set: { newValue in
            store.dispatch(Actions.UpdateFormField(keyPath: \ReviewDetailsForm.dialog, value: newValue).binded(to: self))
        }
    }

    func reviewById(_ id: Review.ID) -> Review {
        isRedacted ? Review.fakeItem() : store.state.allReviews.by(id: id)
    }

    var isRedacted: Bool {
        if case .loading(let id) = flow, self.id == id {
            return true
        }
        return false
    }
}
