//
//  ImageContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF

struct ImageContainer: Container {
    typealias ContainerComponent = ImageComponent

    var size: CGSize
    var path: String?
    var type: ImageType = .poster
    var isLoaderPresented: Bool = true

    func scope(for state: AppState) -> Scope {
        state.imageConfigsForm
    }

    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        .init(
            size: size,
            url: url(for: path, with: size, store.state),
            isLoaderPresented: isLoaderPresented
        )
    }
}

private extension ImageContainer {
    func url(for imagePath: String?, with size: CGSize, _ state: AppState) -> URL? {
        if let imagePath {
            let imageConfigs = state.imageConfigsForm.configs
            let baseUrlPath = imageConfigs.secureBaseUrl
            let sizeUrlPath = imageConfigs.sizeUrlComponent(for: size, in: type.sizes(state))
            // Handling wierd avatar links
            if imagePath.contains("/https://") {
                return URL(string: String(imagePath.dropFirst()))
            }
            return URL(string: baseUrlPath + sizeUrlPath + imagePath)
        }
        return nil
    }
}

extension ImageContainer {
    enum ImageType {
        case backdrop, logo, poster, profile, still

        func sizes(_ state: AppState) -> [Int] {
            let configs = state.imageConfigsForm.configs

            switch self {
            case .backdrop: return configs.backdropSizes
            case .logo: return configs.logoSizes
            case .poster: return configs.posterSizes
            case .profile: return configs.profileSizes
            case .still: return configs.stillSizes
            }
        }
    }
}
