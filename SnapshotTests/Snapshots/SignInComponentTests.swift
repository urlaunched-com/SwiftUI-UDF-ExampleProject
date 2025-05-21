//
//  SignInComponentTests.swift
//  SnapshotTests
//
//  Created by Alexander Sharko on 28.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

@testable import Flick
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

final class SignInComponentTests: SnapshotTestCase {
    override func setUp() {
        isRecording = false
    }

    func test_TextFields_areEmpty() {
        snapshot(
            component: SignInComponent(
                props: .init(
                    username: .constant(""),
                    password: .constant(""),
                    signInAction: {},
                    isLoaderPresented: .constant(false),
                    alertStatus: .constant(.dismissed)
                )
            )
        )
    }

    func test_TextFields_areFilled() {
        snapshot(
            component: SignInComponent(
                props: .init(
                    username: .constant("Username"),
                    password: .constant("Password"),
                    signInAction: {},
                    isLoaderPresented: .constant(false),
                    alertStatus: .constant(.dismissed)
                )
            )
        )
    }

    func test_ColorScheme_isDark() {
        snapshot(
            component: SignInComponent(
                props: .init(
                    username: .constant("Username"),
                    password: .constant("Password"),
                    signInAction: {},
                    isLoaderPresented: .constant(false),
                    alertStatus: .constant(.dismissed)
                )
            ),
            colorScheme: .dark
        )
    }
}
