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

public struct HomeComponent: Component {
    public struct Props {
        var contentType: Binding<ContentType>
        var movieSections: [MovieSection]
        var showSections: [ShowSection]
        var moviesForSection: (MovieSection) -> [Movie]
        var showsForSection: (ShowSection) -> [Show]
        var isMoviesRedacted: (MovieSection) -> Bool
        var isShowsRedacted: (ShowSection) -> Bool
        var dialogStatus: Binding<DialogStatus>
        var destinationBuilder: DestinationBuilder<HomeContent> = .init()
        
        public init(
            contentType: Binding<ContentType>,
            movieSections: [MovieSection],
            showSections: [ShowSection],
            moviesForSection: @escaping (MovieSection) -> [Movie],
            showsForSection: @escaping (ShowSection) -> [Show],
            isMoviesRedacted: @escaping (MovieSection) -> Bool,
            isShowsRedacted: @escaping (ShowSection) -> Bool,
            dialogStatus: Binding<DialogStatus>,
            destinationBuilder: DestinationBuilder<HomeContent> = .init()
        ) {
            self.contentType = contentType
            self.movieSections = movieSections
            self.showSections = showSections
            self.moviesForSection = moviesForSection
            self.showsForSection = showsForSection
            self.isMoviesRedacted = isMoviesRedacted
            self.isShowsRedacted = isShowsRedacted
            self.dialogStatus = dialogStatus
            self.destinationBuilder = destinationBuilder
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
        ForEach(MovieSection.allCases, id: \.self) { (movieSection: MovieSection) in
            let isRedacted = props.isMoviesRedacted(movieSection)
            Group {
                if movieSection == MovieSection.popular {
                    props.destinationBuilder.view(
                        for: .mainHomeSection(
                            section: movieSection,
                            retrieveItems: { props.moviesForSection(movieSection) }
                        )
                    )
                } else {
                    props.destinationBuilder.view(
                        for: .homeSection(
                            section: movieSection,
                            retrieveItems: { props.moviesForSection(movieSection) }
                        )
                    )
                }
            }
            .isRedacted(isRedacted)
            .disabled(isRedacted)
        }
    }

    var showSectionsView: some View {
        ForEach(ShowSection.allCases, id: \.self) { (showSection: ShowSection) in
            let isRedacted = props.isShowsRedacted(showSection)
            Group {
                if showSection == ShowSection.popular {
                    props.destinationBuilder.view(
                        for: .mainHomeSection(
                            section: showSection,
                            retrieveItems: { props.showsForSection(showSection) }
                        )
                    )
                } else {
                    props.destinationBuilder.view(
                        for: .homeSection(
                            section: showSection,
                            retrieveItems: { props.showsForSection(showSection) }
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
            dialogStatus: .constant(.dismissed)
        )
    )
}
