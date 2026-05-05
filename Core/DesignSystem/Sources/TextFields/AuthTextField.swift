//
//  AuthTextField.swift
//  DesignSystem
//
//  Created by Valentin Petrulia on 19.05.2025.
//

import SwiftUI

public struct AuthTextField<Value: Hashable>: View {
    @Binding public var text: String
    public let placeholderImage: Image
    public let placeholderText: String
    public let placeholderColor: Color
    public let isSecure: Bool
    private let textFieldId: Value
    private var isFocused: FocusState<Value?>.Binding

    @State private var isPasswordVisible = false
    @StateObject private var debouncer: Debouncer<String>

    private var isEmpty: Bool { text.isEmpty }

    public init(
        text: Binding<String>,
        placeholderImage: Image,
        placeholderText: String,
        placeholderColor: Color = .flPurpleLight,
        isSecure: Bool = false,
        textFieldId: Value,
        isFocused: FocusState<Value?>.Binding,
        debounceTime: TimeInterval = 0.2
    ) {
        _text = text
        self.placeholderImage = placeholderImage
        self.placeholderText = placeholderText
        self.placeholderColor = placeholderColor
        self.isSecure = isSecure
        self.textFieldId = textFieldId
        self.isFocused = isFocused
        _debouncer = .init(
            wrappedValue: .init(defaultValue: text.wrappedValue, debounceTime: debounceTime)
        )
    }

    public var body: some View {
        VStack(spacing: 10) {
            ZStack {
                HStack(spacing: 6) {
                    placeholderImage
                        .renderingMode(.template)
                    Text(placeholderText)
                }
                .customFont(.caption)
                .foregroundStyle(placeholderColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: isEmpty ? 0 : -26)
                .animation(.easeInOut, value: isEmpty)

                HStack {
                    Group {
                        if isSecure && !isPasswordVisible {
                            SecureField("", text: $debouncer.value)
                        } else {
                            TextField("", text: $debouncer.value)
                        }
                    }
                    .customFont(.body)

                    Button(action: $isPasswordVisible.toggleAction()) {
                        if isSecure && isPasswordVisible {
                            togglePasswordVisibilityImage(.eye)
                        } else if isSecure {
                            togglePasswordVisibilityImage(.eyeSlash)
                        }
                    }
                }
            }
            placeholderColor
                .frame(height: 1)
        }
        .focused(isFocused, equals: textFieldId)
        .onReceive(debouncer.$debouncedValue.dropFirst()) { value in
            self.text = value
        }
        .onChange(of: text) { newValue in
            if debouncer.value.isEmpty && !newValue.isEmpty || newValue == "" {
                debouncer.value = newValue
            }
        }
    }
}

private extension AuthTextField {
    func togglePasswordVisibilityImage(_ image: Image) -> some View {
        image
            .template
            .foregroundStyle(placeholderColor)
    }
}

// MARK: - Preview

#Preview {
    AuthTextField(
        text: .constant("Lewis"),
        placeholderImage: .userCircle,
        placeholderText: "Username",
        placeholderColor: .flPurpleLight,
        textFieldId: 0,
        isFocused: FocusState().projectedValue
    )
}
