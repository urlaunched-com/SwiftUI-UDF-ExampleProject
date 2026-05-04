//
//  Section.swift
//  Flick
//
//  Created by Alexander Sharko on 06.12.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Foundation

protocol Section: Identifiable, CaseIterable, Hashable {
    var title: String { get }
}
