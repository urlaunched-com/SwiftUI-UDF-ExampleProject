//
//  TabBarComponent.swift
//  Flick
//
//  Created by Valentin Petrulia on 27.02.2025.
//  Copyright © 2025 urlaunched.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import SwiftUI_Kit
import UDF
import Common

public struct TabBarComponent: Component {
    public struct Props {
        var selectedTab: Binding<TabBarItem>
        var isHidden: Binding<Bool>

        public init(selectedTab: Binding<TabBarItem>, isHidden: Binding<Bool>) {
            self.selectedTab = selectedTab
            self.isHidden = isHidden
        }
    }

    public var props: Props

    public init(props: Props) {
        self.props = props
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(TabBarItem.allCases, id: \.self) { tab in
                let presenter = TabBarItemPresenter(
                    tabBarItem: tab,
                    isSelected: tab == props.selectedTab.wrappedValue
                )
                ZStack {
                    switch tab {
                    case .randomizer:
                        presenter.icon
                            .background(
                                Circle()
                                    .fill(Color.flMain)
                            )
                    default:
                        presenter.icon
                            .template
                            .foregroundStyle(presenter.foregroundColor)
                    }
                }
                .frame(maxWidth: .infinity)
                .embedInPlainButton {
                    props.selectedTab.wrappedValue = tab
                }
            }
        }
        .frame(height: 55)
        .background(
            VStack(spacing: .zero) {
                Color.flSecondary
                    .frame(height: 1)
                Color.flMain
            }
            .ignoresSafeArea(.container, edges: .bottom)
        )
        .offset(y: props.isHidden.wrappedValue ? 300 : 0)
        .animation(.default, value: props.isHidden.wrappedValue)
    }
}

#Preview {
    TabBarComponent(
        props: .init(
            selectedTab: .constant(.home),
            isHidden: .constant(false)
        )
    )
}
