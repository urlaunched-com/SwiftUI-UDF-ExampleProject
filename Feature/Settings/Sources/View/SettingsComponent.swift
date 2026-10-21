//
//  SettingsComponent.swift
//  Flick
//
//  Created by Arthur Zavolovych on 15.05.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import SwiftUI_Kit
import UDF
import Common

struct SettingsComponent: Component {
    struct Props {
        var rateThisAppAction: Command

        init(rateThisAppAction: @escaping Command) {
            self.rateThisAppAction = rateThisAppAction
        }
    }

    @State private var selectedLink: AppLink?

    var props: Props

    init(props: Props) {
        self.props = props
    }

    var body: some View {
        ScrollView {
            settingsRow(title: SettingsStrings.Settings.privacyPolicyTitle) {
                selectedLink = .privacyPolicy
            }
            settingsRow(title: SettingsStrings.Settings.tmdbAPITitle) {
                selectedLink = .tmdbAPI
            }
            settingsRow(title: SettingsStrings.Settings.aboutUsTitle) {
                selectedLink = .aboutUs
            }
            settingsRow(title: SettingsStrings.Settings.rateThisAppTitle, isLast: true) {
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
                Text(SettingsStrings.Settings.navigationTitle)
                    .customFont(.headline)
                    .foregroundStyle(.flDark)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

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
