//
//  AppState+.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SectionDetails
import Home
import NetworkConnectivity
import UDF
import Models

extension AppState: SectionDetailsFeature {}

extension NetworkConnectivity.NetworkConnectivityForm: SectionDetails.NetworkConnectivityForm {}
extension HomeForm: SectionDetails.HomeForm {}
extension AllMovies: SectionDetails.AllMovies {}
extension AllShows: SectionDetails.AllShows {}
