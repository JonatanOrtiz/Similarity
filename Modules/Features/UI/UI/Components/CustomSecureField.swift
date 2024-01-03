//
//  CustomSecureField.swift
//  UI
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

public struct CustomSecureField: View {
    @Binding public var text: String
    public let placeholder: String
    public let textContentType: UITextContentType?

    public init(
        text: Binding<String>,
        placeholder: String,
        textContentType: UITextContentType? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.textContentType = textContentType
    }

    public var body: some View {
        SecureField(placeholder, text: $text)
            .textFieldStyle(CustomTextFieldStyle())
            .textContentType(textContentType)
    }
}
