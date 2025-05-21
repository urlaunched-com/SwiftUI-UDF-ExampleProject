//
//  HomeComponent.swift
//  Flick
//
//  Created by Alexander Sharko on 30.11.2022.
//  Copyright © 2022 urlaunched.com. All rights reserved.
//

import Localizations
import SwiftUI
import UDF

struct HomeComponent: Component {
    struct Props {
        var contentType: Binding<ContentType>
        var movieSections: [MovieSection]
        var showSections: [ShowSection]
        var moviesForSection: (MovieSection) -> [Movie]
        var showsForSection: (ShowSection) -> [Show]
        var isMoviesRedacted: (MovieSection) -> Bool
        var isShowsRedacted: (ShowSection) -> Bool
        var alertStatus: Binding<AlertBuilder.AlertStatus>
    }

    var props: Props

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ContentToggle(contentType: props.contentType)

                switch props.contentType.wrappedValue {
                case .movie:
                    movieSectionsView
                case .show:
                    showSectionsView
                }
            }
            .padding(.bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
        .customNavigationTitle(Localization.homeNavigationTitle())
    }
}

extension HomeComponent {
    var movieSectionsView: some View {
        ForEach(MovieSection.allCases) { movieSection in
            let isRedacted = props.isMoviesRedacted(movieSection)
            Group {
                if movieSection == MovieSection.popular {
                    MainHomeSectionContainer(
                        section: movieSection,
                        retrieveItems: { props.moviesForSection(movieSection) },
                        scopeOfWork: { state in state.allMovies }
                    )
                } else {
                    HomeSectionContainer(
                        section: movieSection,
                        retrieveItems: { props.moviesForSection(movieSection) },
                        scopeOfWork: { state in state.allMovies }
                    )
                }
            }
            .isRedacted(isRedacted)
            .disabled(isRedacted)
        }
    }

    var showSectionsView: some View {
        ForEach(ShowSection.allCases) { showSection in
            let isRedacted = props.isShowsRedacted(showSection)
            Group {
                if showSection == ShowSection.popular {
                    MainHomeSectionContainer(
                        section: showSection,
                        retrieveItems: { props.showsForSection(showSection) },
                        scopeOfWork: { state in state.allShows }
                    )
                } else {
                    HomeSectionContainer(
                        section: showSection,
                        retrieveItems: { props.showsForSection(showSection) },
                        scopeOfWork: { state in state.allShows }
                    )
                }
            }
            .isRedacted(isRedacted)
            .disabled(isRedacted)
        }
        .alert(status: props.alertStatus)
    }
}

// MARK: - Preview

#Preview {
    HomeComponent(
        props: .init(
            contentType: .constant(.movie),
            movieSections: [],
            showSections: [],
            moviesForSection: { _ in Movie.fakeItems() },
            showsForSection: { _ in Show.fakeItems() },
            isMoviesRedacted: { _ in false },
            isShowsRedacted: { _ in false },
            alertStatus: .constant(.dismissed)
        )
    )
}
