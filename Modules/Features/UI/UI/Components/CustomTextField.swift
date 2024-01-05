//
//  CustomTextField.swift
//  UI
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

public struct CustomTextField: View {
    @Binding public var text: String
    public let placeholder: String
    public let keyboardType: UIKeyboardType?
    public let textContentType: UITextContentType?
    public let autocapitalization: UITextAutocapitalizationType?

    public init(
        text: Binding<String>,
        placeholder: String,
        keyboardType: UIKeyboardType? = nil,
        textContentType: UITextContentType? = nil,
        autocapitalization: UITextAutocapitalizationType? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.autocapitalization = autocapitalization
    }

    public var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(CustomTextFieldStyle())
            .keyboardType(keyboardType ?? .default)
            .textContentType(textContentType)
            .autocapitalization(autocapitalization ?? .none)
            .autocorrectionDisabled()
    }
}
