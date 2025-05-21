//
//  SearchTextField.swift
//  DesignSystem
//
//  Created by Valentin Petrulia on 15.05.2025.
//

import SwiftUI
import SwiftUI_Kit

public struct SearchTextField<Value: Hashable>: View {
    private let placeholder: String
    @Binding private var text: String
    private let textFieldId: Value
    private var isFocused: FocusState<Value?>.Binding
    @StateObject private var debouncer: Debouncer<String>

    public init(
        placeholder: String,
        text: Binding<String>,
        textFieldId: Value,
        isFocused: FocusState<Value?>.Binding,
        debounceTime: TimeInterval = 0.2
    ) {
        self.placeholder = placeholder
        _text = text
        self.textFieldId = textFieldId
        self.isFocused = isFocused
        _debouncer = .init(
            wrappedValue: .init(defaultValue: text.wrappedValue, debounceTime: debounceTime)
        )
    }

    public var body: some View {
        ZStack(alignment: .trailing) {
            TextField(placeholder, text: $debouncer.value)
                .textInputAutocapitalization(.never)
                .foregroundStyle(text.isEmpty ? .flPurpleLight : .flText)
            Image
                .search
                .template
                .aspectFit()
                .frame(24)
                .foregroundStyle(text.isEmpty ? .flPurpleLight : .flText)
        }
        .onReceive(debouncer.$debouncedValue.dropFirst()) { value in
            self.text = value
        }
        .onChange(of: text) { newValue in
            if debouncer.value.isEmpty && !newValue.isEmpty || newValue == "" {
                debouncer.value = newValue
            }
        }
        .focused(isFocused, equals: textFieldId)
        .frame(height: 54)
        .padding(.horizontal)
        .customFont(.subheadline)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.flSecondary)
        )
    }
}
