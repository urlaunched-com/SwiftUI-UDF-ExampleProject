//
//  ItemDetailsApp.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//

import Common
import ItemDetails
import Models
import SwiftUI

@main
struct ItemDetailsApp: App {
    var body: some Scene {
        WindowGroup {
            ItemDetailsComponent<MockRouter>(
                props: .init(
                    item: Movie.fakeItem(),
                    genreById: { _ in .fakeItem() },
                    dialog: .constant(.dismissed)
                )
            )
        }
    }
}
