//
//  AppState+.swift
//  Flick
//
//  Created by Bogdan Petkanych on 22.07.2026.
//  Copyright © 2026 urlaunched. All rights reserved.
//

import SectionDetails
import Home

extension AppState: SectionDetailsFeature {}

extension NetworkConnectivityForm: SectionDetails.NetworkConnectivityForm {}
extension HomeForm: SectionDetails.HomeForm {}
extension AllMovies: SectionDetails.AllMovies {}
extension AllShows: SectionDetails.AllShows {}
extension AllGenres: SectionDetails.AllGenres {}

