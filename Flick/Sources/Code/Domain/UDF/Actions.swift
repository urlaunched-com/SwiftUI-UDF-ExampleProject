//
//  Actions.swift
//  Flick
//
//  Created by Alexander Sharko on 17.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

extension Actions {
    struct SignIn: Action {}

    struct UpdateNetworkConnectivityStatus: Action {
        let satisfied: Bool
    }

    struct SectionOpened<H: Hashable>: Action {
        let sectionId: H
    }

    struct LoadItemDetails<H: Hashable>: Action {
        let itemId: H
    }

    struct LoadItemCast<H: Hashable>: Action {
        let itemId: H
    }
}
