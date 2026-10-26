//
//  View+OnDeepLink.swift
//  Flick
//
//  Created by Maksym Horobets on 22.10.2026.
//  © 2026 You are launched
//

import SwiftUI

extension View {
    /// Receives custom-scheme URLs and universal links in one place.
    func onDeepLink(perform action: @escaping (URL) -> Void) -> some View {
        onOpenURL(perform: action)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
                if let url = activity.webpageURL {
                    action(url)
                }
            }
    }
}
