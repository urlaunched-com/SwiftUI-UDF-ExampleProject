//
//  SignInComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import DesignSystem
import Localizations
import SwiftUI
import UDF

struct SignInComponent: Component {
    struct Props {
        var username: Binding<String>
        var password: Binding<String>
        var signInAction: Command
        var isLoaderPresented: Binding<Bool>
        var alertStatus: Binding<AlertBuilder.AlertStatus>
        var router: Router<SignInRouting> = .init()
    }

    var props: Props

    @FocusState private var focusedField: Field?
    @Environment(\.globalRouter) private var globalRouter

    var body: some View {
        AuthView(title: Localization.authSignUpTitle()) {
            VStack {
                AuthTextField(
                    text: props.username,
                    placeholderImage: .userCircle,
                    placeholderText: Localization.authUsernamePlaceholder(),
                    placeholderColor: .flPurpleLight,
                    textFieldId: Field.username,
                    isFocused: $focusedField
                )
                .onTapGesture {
                    focusedField = .username
                }
                .padding(.top, 60)

                AuthTextField(
                    text: props.password,
                    placeholderImage: .lock,
                    placeholderText: Localization.authPasswordPlaceholder(),
                    placeholderColor: .flPurpleLight,
                    isSecure: true,
                    textFieldId: Field.password,
                    isFocused: $focusedField
                )
                .onTapGesture {
                    focusedField = .password
                }
                .padding(.top, 60)

                Text(Localization.authForgotPasswordButtonTitle())
                    .customFont(.subheadline)
                    .foregroundStyle(.flMainPink)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .embedInPlainButton {
                        globalRouter.navigate(to: .resetPassword, with: props.router)
                    }
                    .padding(.top)

                PrimaryButton(
                    title: Localization.authSignInButtonTitle(),
                    action: signInAction
                )
                .padding(.top, 36)

                HStack {
                    Text(Localization.authSignUpButtonDescription())
                        .foregroundStyle(.flText)

                    Text(Localization.authSignUpButtonTitle())
                        .foregroundStyle(.flMainPink)
                        .embedInPlainButton {
                            globalRouter.navigate(to: .signUp, with: props.router)
                        }
                }
                .customFont(.subheadline)
                .padding(.top, 24)
                Spacer()
            }
            .padding(.horizontal)
        }
        .onTapGesture {
            focusedField = .none
        }
        .hideKeyboardByTap()
        .navigationDestination(for: SignInRouting.self)
        .embedInNavigationStack()
        .alert(status: props.alertStatus)
        .loaderSheet(isPresented: props.isLoaderPresented)
    }
}

private extension SignInComponent {
    func signInAction() {
        if props.username.wrappedValue.isEmpty {
            focusedField = .username
        } else if props.password.wrappedValue.isEmpty {
            focusedField = .password
        } else {
            props.signInAction()
        }
    }
}

private extension SignInComponent {
    enum Field {
        case username
        case password
    }
}

// MARK: - Preview

#Preview {
    SignInComponent(
        props: .init(
            username: .constant("Lewis_Champion"),
            password: .constant(""),
            signInAction: {},
            isLoaderPresented: .constant(false),
            alertStatus: .constant(.dismissed)
        )
    )
}
