//
//  UIApplication+.swift
//  Flick
//
//  Created by Valentin Petrulia on 06.03.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import StoreKit
import UIKit

extension UIApplication {
    func requestReview() {
        DispatchQueue.main.async {
            if let scene = self.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
