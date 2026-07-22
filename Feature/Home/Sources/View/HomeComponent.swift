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
import Models
import Common
import CustomViews

public struct HomeComponent<R: Routing>: Component where R.Route == HomeRoute {
    public struct Props {
        var contentType: Binding<ContentType>
        var movieSections: [MovieSection]
        var showSections: [ShowSection]
        var moviesForSection: (MovieSection) -> [Movie]
        var showsForSection: (ShowSection) -> [Show]
        var isMoviesRedacted: (MovieSection) -> Bool
        var isShowsRedacted: (ShowSection) -> Bool
        var dialogStatus: Binding<DialogStatus>
        var router: R

        public init(
            contentType: Binding<ContentType>,
            movieSections: [MovieSection],
            showSections: [ShowSection],
            moviesForSection: @escaping (MovieSection) -> [Movie],
            showsForSection: @escaping (ShowSection) -> [Show],
            isMoviesRedacted: @escaping (MovieSection) -> Bool,
            isShowsRedacted: @escaping (ShowSection) -> Bool,
            dialogStatus: Binding<DialogStatus>,
            router: R
        ) {
            self.contentType = contentType
            self.movieSections = movieSections
            self.showSections = showSections
            self.moviesForSection = moviesForSection
            self.showsForSection = showsForSection
            self.isMoviesRedacted = isMoviesRedacted
            self.isShowsRedacted = isShowsRedacted
            self.dialogStatus = dialogStatus
            self.router = router
        }
    }

    public var props: Props

    public init(props: Props) {
        self.props = props
    }

    public var body: some View {
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
        ForEach(props.movieSections, id: \.self) { movieSection in
            let isRedacted = props.isMoviesRedacted(movieSection)
            Group {
                if movieSection == .popular {
                    props.router.view(
                        for: .mainMovieSection(
                            section: movieSection,
                            items: props.moviesForSection(movieSection)
                        )
                    )
                } else {
                    props.router.view(
                        for: .movieSection(
                            section: movieSection,
                            items: props.moviesForSection(movieSection)
                        )
                    )
                }
            }
            .isRedacted(isRedacted)
            .disabled(isRedacted)
        }
    }

    var showSectionsView: some View {
        ForEach(props.showSections, id: \.self) { showSection in
            let isRedacted = props.isShowsRedacted(showSection)
            Group {
                if showSection == .popular {
                    props.router.view(
                        for: .mainShowSection(
                            section: showSection,
                            items: props.showsForSection(showSection)
                        )
                    )
                } else {
                    props.router.view(
                        for: .showSection(
                            section: showSection,
                            items: props.showsForSection(showSection)
                        )
                    )
                }
            }
            .isRedacted(isRedacted)
            .disabled(isRedacted)
        }
        .dialog(status: props.dialogStatus)
    }
}

#Preview {
    HomeComponent(
        props: .init(
            contentType: .constant(.movie),
            movieSections: MovieSection.allCases,
            showSections: ShowSection.allCases,
            moviesForSection: { _ in Movie.fakeItems() },
            showsForSection: { _ in Show.fakeItems() },
            isMoviesRedacted: { _ in false },
            isShowsRedacted: { _ in false },
            dialogStatus: .constant(.dismissed),
            router: MockRouter<HomeRoute>()
        )
    )
}
