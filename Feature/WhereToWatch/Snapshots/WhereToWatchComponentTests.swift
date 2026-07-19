//
//  WhereToWatchComponentTests.swift
//  SnapshotTests
//
//  Created by Alexander Sharko on 19.07.2026.
//

@testable import WhereToWatch
import Foundation
import SwiftUI
import SwiftUISnapshotTestCase
import UDF
import XCTest
import Common
import Models
import FlagKit

final class WhereToWatchComponentTests: BaseSnapshotTestCase {
    var dropDownItems: [DropdownItem] {
        let codes = [
            "AL", "SA", "AM", "AZ", "BY", "BA", "BG", "MM", "CN", "HR", "CZ", "DK", "MV", "NL",
            "EE", "FJ", "FI", "FR", "GE", "DE", "GR", "HT", "IN", "HU", "ID", "GB", "IS", "IT",
            "JP", "GL", "KZ", "KG", "KR", "LT", "LV", "MK", "MT", "MN", "NP", "NO", "PL", "PT",
            "RO", "RS", "SK", "SI", "SO", "ES", "SE", "TJ", "TH", "BO", "TM", "TR", "UA", "UZ", "VN",
        ]

        return codes.compactMap { code in
            guard let flag = Flag(countryCode: code) else { return nil }
            let image = flag.originalImage
            return .init(title: code, image: image)
        }
    }
    
    override func setUp() {
        isRecording = false
        super.setUp()
    }

    func test_WhereToWatch_initial_state() {
        snapshot(
            component: WhereToWatchComponent(props: WhereToWatchComponent.Props(
                item: Show.testItem(),
                countries: dropDownItems,
                providers: Provider.fakeItems(count: 3),
                router: MockRouter<WhereToWatchRouter>()
            ))
        )
    }
}
