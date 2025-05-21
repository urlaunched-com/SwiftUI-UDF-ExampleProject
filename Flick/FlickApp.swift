//
//  FlickApp.swift
//  Flick
//
//  Created by Max Kuznetsov on 02.11.2022.
//

import API
import SwiftUI
import UDF

private let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJidW5kbGVfaWRzIjpbImNvbS51cmxhdW5jaGVkLmZsaWNrIl19.HjROptJlsO915Ju0fw7VtO-FhHZlZSdDRALOrFQOvPU"
private var store: EnvironmentStore<AppState>!

@main
struct FlickApp: App {
    init() {
        store = EnvironmentStore(
            initial: AppState(),
            logger: .consoleDebug
        )
        
        checkAPIKey()
        originalSubscribe()
        configureAppearances()
    }

    var body: some Scene {
        WindowGroup {
            RootContainer()
        }
    }
}

// MARK: - Store subscriptions

private extension FlickApp {
    func originalSubscribe() {
        store.subscribe { _ in
            HomeMiddleware.self
            GenresMiddleware.self
            NetworkConnectivityMiddleware.self
            ImageConfigsMiddleware.self
            SectionDetailsMiddleware.self
            MovieDetailsMiddleware.self
            ShowDetailsMiddleware.self
            MovieCastMiddleware.self
            ShowCastMiddleware.self
            MovieRecommendationsMiddleware.self
            ShowRecommendationsMiddleware.self
            MovieReviewsMiddleware.self
            ShowReviewsMiddleware.self
            SearchMiddleware.self
            MyFavoritesMiddleware.self
        }
    }
}

extension FlickApp {
    func configureAppearances() {
        let backImage = UIImage(systemName: "chevron.left")?.withTintColor(UIColor(.flMainPink), renderingMode: .alwaysOriginal)
        let navigationBarAppearance = UINavigationBarAppearance()
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.flMainPink)]
        navigationBarAppearance.backgroundColor = UIColor(Color.flMain)
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.buttonAppearance = buttonAppearance
        navigationBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.red)]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}

private extension FlickApp {
    func checkAPIKey() {
        guard kTMDBApiKey.isNotEmpty else {
            fatalError("API key was not found in BaseAPI.swift")
        }
        self.configureAppearances()
    }
}
