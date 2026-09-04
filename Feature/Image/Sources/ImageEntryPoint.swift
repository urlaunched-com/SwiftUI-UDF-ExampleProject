//
//  ImageEntryPoint.swift
//  Flick
//
//  Created by Bogdan Petkanych on 31.08.2026.
//

import SwiftUI
import Common
import UDF

public struct ImageEntryPoint<F: ImageFeature>: FeatureEntryPoint {
    public struct Parameters {
        public let size: CGSize
        public let path: String?
        public let type: ImageType
        public let isLoaderPresented: Bool

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
    }

    public static func make(with parameters: Parameters) -> some View {
        ImageContainer<F>(
            size: parameters.size,
            path: parameters.path,
            type: parameters.type,
            isLoaderPresented: parameters.isLoaderPresented
        )
    }
}
