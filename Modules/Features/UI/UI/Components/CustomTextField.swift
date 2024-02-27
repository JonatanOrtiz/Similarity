//
//  CustomTextField.swift
//  UI
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

public struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType?
    let textContentType: UITextContentType?
    let autocapitalization: UITextAutocapitalizationType?
    let backgroundColor: Color

    public init(
        text: Binding<String>,
        placeholder: String,
        keyboardType: UIKeyboardType? = nil,
        textContentType: UITextContentType? = nil,
        autocapitalization: UITextAutocapitalizationType? = nil,
        backgroundColor: Color = .clear
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(CustomTextFieldStyle(backgroundColor: backgroundColor))
            .keyboardType(keyboardType ?? .default)
            .textContentType(textContentType)
            .autocapitalization(autocapitalization ?? .none)
            .autocorrectionDisabled()
    }
}
