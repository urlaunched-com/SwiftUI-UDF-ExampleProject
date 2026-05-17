//
//  SettingsComponent.swift
//  Flick
//
//  Created by Arthur Zavolovych on 15.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI
import SwiftUI_Kit
import UDF
import Common

public struct SettingsComponent: Component {
    public struct Props {
        var rateThisAppAction: Command
        
        public init(rateThisAppAction: @escaping Command) {
            self.rateThisAppAction = rateThisAppAction
        }
    }

    @State private var selectedLink: AppLink?

    public var props: Props
    
    public init(props: Props) {
        self.props = props
    }

    public var body: some View {
        ScrollView {
            settingsRow(title: Localization.settingsPrivacyPolicyTitle()) {
                selectedLink = .privacyPolicy
            }
            settingsRow(title: Localization.settingsTmdbAPITitle()) {
                selectedLink = .tmdbAPI
            }
            settingsRow(title: Localization.settingsAboutUsTitle()) {
                selectedLink = .aboutUs
            }
            settingsRow(title: Localization.settingsRateThisAppTitle(), isLast: true) {
                props.rateThisAppAction()
            }
        }
        .padding()
        .sheet(item: $selectedLink) {
            SafariView(url: $0.urlValue)
                .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Localization.settingsNavigationTitle())
                    .customFont(.headline)
                    .foregroundStyle(.flDark)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - SettingsRow

private extension SettingsComponent {
    func settingsRow(
        title: String,
        isLast: Bool = false,
        action: @escaping () -> Void
    ) -> some View {
        VStack {
            HStack {
                Text(title)
                    .customFont(.body)
                    .foregroundStyle(.flText)
                Spacer()
                Image.Arrow.right
                    .aspectFit()
                    .frame(width: 24.0, height: 24.0)
            }
            .padding(.vertical, 19.0)
            if !isLast {
                Divider()
                    .background(Color.flSecondary)
            }
        }
        .embedInPlainButton(action: action)
    }
}
