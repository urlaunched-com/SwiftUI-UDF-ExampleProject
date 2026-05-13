//
//  SignInComponentTests.swift
//  SnapshotTests
//
//  Created by Alexander Sharko on 28.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

@testable import SignInComponentSnapshotTestsHostApp
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest

@MainActor
final class SignInComponentTests: BaseSnapshotTestCase {
    private var initialComponent: SignInComponent!
    
    override func setUp() {
        super.setUp()
        isRecording = false
        
        initialComponent = .init(
            props: .init(
                username: .constant(""),
                password: .constant(""),
                signInAction: {},
                isLoaderPresented: .constant(false),
                dialogStatus: .constant(.dismissed)
            )
        )
    }
    
    override func tearDown() {
        initialComponent = nil
        super.tearDown()
    }


    func test_TextFields_areEmpty() {
        snapshot(for: initialComponent)
    }

    func test_TextFields_areFilled() {
        initialComponent.props.password = .constant("Password")
        initialComponent.props.username = .constant("Username")

        snapshot(for: initialComponent)
    }
}
