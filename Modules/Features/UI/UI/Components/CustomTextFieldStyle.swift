//
//  CustomTextFieldStyle.swift
//  UI
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    let backgroundColor: Color

    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .foregroundColor(.primaryColor)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(backgroundColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20).stroke(Color.primaryColor, lineWidth: 1)
            )
    }
}
