//
//  MainSectionScrollView.swift
//  Flick
//
//  Created by Alexander Sharko on 04.01.2023.
//  Copyright © 2023 urlaunched.com. All rights reserved.
//

import Combine
import DesignSystem
import SwiftUI
import UDF

struct MainSectionScrollView: View {
    var items: [any Item]
    var genresByItem: (any Item) -> String
    var navigateToItemDetails: (any Item) -> Void

    @State private var midItemIndex: Int = 0
    @State private var scale: [Int: CGFloat] = [:]
    @State private var angle: [Int: Angle] = [:]
    @State private var opacity: [Int: CGFloat] = [:]

    let stickyScrollService = StickyScrollService()
    fileprivate var stickyScrollPublisher: AnyPublisher<Int, Never> {
        stickyScrollService.currentValueSubject
            .receive(on: DispatchQueue.main)
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }

    var body: some View {
        GeometryReader { geometry in
            let padding = abs((geometry.size.width - 202) / 2)
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top, spacing: 16) {
                        ForEach(items.indices, id: \.self) { index in
                            let item = items[index]
                            cardView(
                                item: item,
                                listMidX: geometry.frame(in: .global).midX,
                                itemIndex: index
                            )
                            .padding(.leading, index == items.indices.first ? padding : 0)
                            .padding(.trailing, index == items.indices.last ? padding : 0)
                            .embedInPlainButton {
                                navigateToItemDetails(item)
                            }
                            .buttonStyle(.scaled)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .onReceive(stickyScrollPublisher) { index in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        proxy.scrollTo(index, anchor: .center)
                    }
                }
            }
            .background(
                ZStack {
                    LinearGradient.primaryBackground
                    ImageContainer(
                        size: .init(width: geometry.size.width * 2, height: geometry.size.height * 2),
                        path: items[safeIndex: midItemIndex]?.backdropPath,
                        type: .backdrop,
                        isLoaderPresented: false
                    )
                    .frame(geometry.size)
                    .clipShape(Rectangle())
                    .opacity(0.5)
                    .animation(.easeInOut(duration: 0.5))
                    LinearGradient(colors: [.flMain, .clear], startPoint: .top, endPoint: .bottom)
                }
            )
        }
    }
}

// MARK: - Card view

private extension MainSectionScrollView {
    func cardView(item: any Item, listMidX: CGFloat, itemIndex index: Int) -> some View {
        HomeCardView(
            item: item,
            genres: genresByItem(item),
            style: .main,
            textOpacity: opacity[index] ?? 1
        )
        .scaleEffect(scale[index] ?? 1, anchor: .bottom)
        .rotationEffect(angle[index] ?? Angle(degrees: 0))
        .tag(index)
        .background(
            GeometryReader { geometry in
                let cardMidX = geometry.frame(in: .global).midX
                Color.clear
                    .preference(
                        key: OffsetPreferenceKey.self,
                        value: listMidX - cardMidX
                    )
                    .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                        if abs(offset) < 100 { midItemIndex = index }
                        stickyScrollService.updateIndex(midItemIndex)
                        scale[index] = 1 - abs(offset) * 0.001
                        angle[index] = Angle(degrees: offset * -0.03)
                        opacity[index] = 1 - abs(offset) * 0.005
                    }
            }
        )
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Preview

#Preview {
    MainSectionScrollView(
        items: Movie.fakeItems(),
        genresByItem: { _ in "Fake genre" },
        navigateToItemDetails: { _ in }
    )
}
