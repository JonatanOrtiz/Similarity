//
//  CustomTextFieldStyle.swift
//  UI
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .foregroundColor(.primary)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
    }
}
