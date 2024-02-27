//
//  CustomSecureField.swift
//  UI
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

public struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: String
    let textContentType: UITextContentType?
    let backgroundColor: Color

    public init(
        text: Binding<String>,
        placeholder: String,
        textContentType: UITextContentType? = nil,
        backgroundColor: Color = .clear
    ) {
        self._text = text
        self.placeholder = placeholder
        self.textContentType = textContentType
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        SecureField(placeholder, text: $text)
            .textFieldStyle(CustomTextFieldStyle(backgroundColor: backgroundColor))
            .textContentType(textContentType)
    }
}
