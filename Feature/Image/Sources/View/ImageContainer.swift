//
//  ImageContainer.swift
//  Flick
//
//  Created by Alexander Sharko on 03.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import SwiftUI
import UDF
import Common

public struct ImageContainer<F: ImageFeature>: Container {
    public typealias ContainerComponent = ImageComponent

    public var size: CGSize
    public var path: String?
    public var type: ImageType = .poster
    public var isLoaderPresented: Bool = true

    public init(
        size: CGSize,
        path: String?,
        type: ImageType = .poster,
        isLoaderPresented: Bool = true
    ) {
        self.size = size
        self.path = path
        self.type = type
        self.isLoaderPresented = isLoaderPresented
    }

    public func scope(for state: F) -> Scope {
        state.imageConfigsForm
    }

    public func map(store: EnvironmentStore<F>) -> ContainerComponent.Props {
        .init(
            size: size,
            url: url(for: path, with: size, store.state),
            isLoaderPresented: isLoaderPresented
        )
    }
}

private extension ImageContainer {
    func url(for imagePath: String?, with size: CGSize, _ state: F) -> URL? {
        guard let imagePath else {
            return nil
        }

        let imageConfigs = state.imageConfigsForm.configs
        let baseUrlPath = imageConfigs.secureBaseUrl
        let sizeUrlPath = imageConfigs.sizeUrlComponent(for: size, in: sizes(for: state))

        if imagePath.contains("/https://") {
            return URL(string: String(imagePath.dropFirst()))
        }

        return URL(string: baseUrlPath + sizeUrlPath + imagePath)
    }

    func sizes(for state: F) -> [Int] {
        let configs = state.imageConfigsForm.configs

        switch type {
        case .backdrop:
            return configs.backdropSizes
        case .logo:
            return configs.logoSizes
        case .poster:
            return configs.posterSizes
        case .profile:
            return configs.profileSizes
        case .still:
            return configs.stillSizes
        }
    }
}
